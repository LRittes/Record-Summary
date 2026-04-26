import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:record_summary/domain/entities/transcription_segment.dart';
import 'package:record_summary/domain/exceptions/transcription_exception.dart';
import 'package:record_summary/domain/services/llm_api_client.dart';
import 'package:record_summary/domain/services/transcription_service.dart';
import 'package:uuid/uuid.dart';

typedef ChannelExtractor = Future<File> Function(String audioPath, int channel);

Future<File> defaultChannelExtractor(String audioPath, int channel) async {
  final outPath = '${audioPath}_ch$channel.m4a';
  final result = await Process.run('ffmpeg', [
    '-y',
    '-i', audioPath,
    '-af', 'pan=mono|c0=c$channel',
    '-c:a', 'aac',
    outPath,
  ]);

  if (result.exitCode != 0) {
    throw TranscriptionException(
      'ffmpeg channel extraction failed: ${result.stderr}',
    );
  }

  return File(outPath);
}

class WhisperTranscriptionService implements TranscriptionService {
  const WhisperTranscriptionService(
    this._client, {
    http.Client? httpClient,
    ChannelExtractor? channelExtractor,
  })  : _httpClient = httpClient,
        _channelExtractor = channelExtractor ?? defaultChannelExtractor;

  final LlmApiClient _client;
  final http.Client? _httpClient;
  final ChannelExtractor _channelExtractor;

  static const _whisperUrl = 'https://api.openai.com/v1/audio/transcriptions';
  static const _model = 'whisper-1';
  static const _uuid = Uuid();

  http.Client get _http => _httpClient ?? http.Client();

  @override
  Future<List<TranscriptionSegment>> transcribe({
    required String callId,
    required String audioPath,
  }) async {
    if (!File(audioPath).existsSync()) {
      throw TranscriptionException('Audio file not found: $audioPath');
    }

    final segments = await Future.wait([
      _transcribeChannel(
        callId: callId,
        audioPath: audioPath,
        speaker: Speaker.local,
        channel: 0,
      ),
      _transcribeChannel(
        callId: callId,
        audioPath: audioPath,
        speaker: Speaker.remote,
        channel: 1,
      ),
    ]);

    return _mergeAndSort(segments[0], segments[1]);
  }

  Future<List<TranscriptionSegment>> _transcribeChannel({
    required String callId,
    required String audioPath,
    required Speaker speaker,
    required int channel,
  }) async {
    final channelFile = await _channelExtractor(audioPath, channel);

    try {
      final bytes = await channelFile.readAsBytes();
      final request = http.MultipartRequest('POST', Uri.parse(_whisperUrl))
        ..headers['Authorization'] = 'Bearer ${_client.apiKey}'
        ..fields['model'] = _model
        ..fields['response_format'] = 'verbose_json'
        ..fields['timestamp_granularities[]'] = 'segment'
        ..files.add(http.MultipartFile.fromBytes(
          'file',
          bytes,
          filename: 'audio_ch$channel.m4a',
        ));

      final streamed = await _http.send(request);
      final body = await streamed.stream.bytesToString();

      if (streamed.statusCode != 200) {
        throw TranscriptionException(body, statusCode: streamed.statusCode);
      }

      final json = jsonDecode(body) as Map<String, dynamic>;
      return _parseSegments(json, callId, speaker);
    } finally {
      if (channelFile.existsSync()) await channelFile.delete();
    }
  }

  List<TranscriptionSegment> _parseSegments(
    Map<String, dynamic> json,
    String callId,
    Speaker speaker,
  ) {
    final segments = json['segments'] as List<dynamic>? ?? [];
    return segments.map((s) {
      final map = s as Map<String, dynamic>;
      return TranscriptionSegment(
        id: _uuid.v4(),
        callId: callId,
        speaker: speaker,
        text: (map['text'] as String).trim(),
        startAt: _secondsToDuration(map['start'] as num),
        endAt: _secondsToDuration(map['end'] as num),
      );
    }).toList();
  }

  List<TranscriptionSegment> _mergeAndSort(
    List<TranscriptionSegment> local,
    List<TranscriptionSegment> remote,
  ) =>
      [...local, ...remote]
        ..sort((a, b) => a.startAt.compareTo(b.startAt));

  Duration _secondsToDuration(num seconds) =>
      Duration(milliseconds: (seconds * 1000).round());
}
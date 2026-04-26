import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:record_summary/data/services/whisper_transcription_service.dart';
import 'package:record_summary/domain/entities/transcription_segment.dart';
import 'package:record_summary/domain/exceptions/transcription_exception.dart';
import 'package:record_summary/domain/services/llm_api_client.dart';

class _FakeApiClient implements LlmApiClient {
  @override
  String get apiKey => 'test-key';

  @override
  String get baseUrl => 'https://api.openai.com';
}

Future<File> _passthroughExtractor(String audioPath, int channel) async =>
    File(audioPath);

Map<String, dynamic> _whisperResponse(List<Map<String, dynamic>> segments) => {
  'task': 'transcribe',
  'language': 'portuguese',
  'duration': 10.0,
  'segments': segments,
  'text': segments.map((s) => s['text']).join(' '),
};

Map<String, dynamic> _segment({
  required int id,
  required String text,
  required double start,
  required double end,
}) => {
  'id': id,
  'seek': 0,
  'start': start,
  'end': end,
  'text': text,
  'tokens': <int>[],
  'temperature': 0.0,
  'avg_logprob': -0.2,
  'compression_ratio': 1.2,
  'no_speech_prob': 0.01,
};

File _tempAudio() {
  final f = File('${Directory.systemTemp.path}/test_audio.m4a');
  f.writeAsBytesSync([]);
  return f;
}

WhisperTranscriptionService _service(http.Client mockHttp) =>
    WhisperTranscriptionService(
      _FakeApiClient(),
      httpClient: mockHttp,
      channelExtractor: _passthroughExtractor,
    );

void main() {
  late File audioFile;

  setUp(() => audioFile = _tempAudio());
  tearDown(() {
    if (audioFile.existsSync()) audioFile.deleteSync();
  });

  group('WhisperTranscriptionService', () {
    test('throws TranscriptionException when file does not exist', () {
      final service = _service(MockClient((_) async => http.Response('', 200)));
      expect(
        () => service.transcribe(callId: 'c-1', audioPath: '/no/such/file.m4a'),
        throwsA(isA<TranscriptionException>()),
      );
    });

    test('throws TranscriptionException on non-200 response', () {
      final service = _service(
        MockClient((_) async => http.Response('{"error":"invalid key"}', 401)),
      );
      expect(
        () => service.transcribe(callId: 'c-1', audioPath: audioFile.path),
        throwsA(
          isA<TranscriptionException>().having(
            (e) => e.statusCode,
            'statusCode',
            401,
          ),
        ),
      );
    });

    test('parses segments and assigns speaker correctly', () async {
      final service = _service(MockClient((request) async {
      final isChannel0 = request.body.contains('audio_ch0');
      final body = isChannel0
            ? _whisperResponse([
                _segment(id: 0, text: 'Ola, tudo bem?', start: 0.0, end: 2.0),
              ])
            : _whisperResponse([
                _segment(id: 0, text: 'Tudo otimo!', start: 1.5, end: 3.0),
              ]);
        return http.Response(
          jsonEncode(body),
          200,
          headers: {'content-type': 'application/json; charset=utf-8'},
        );
      }));

      final result =
          await service.transcribe(callId: 'c-1', audioPath: audioFile.path);

      expect(result.length, 2);
      expect(result[0].text, 'Ola, tudo bem?');
      expect(result[0].speaker, Speaker.local);
      expect(result[1].text, 'Tudo otimo!');
      expect(result[1].speaker, Speaker.remote);
    });

    test('segments are sorted by startAt ascending', () async {
      final service = _service(MockClient((request) async {
        final isChannel0 = request.body.contains('audio_ch0');
        final body = isChannel0
            ? _whisperResponse([
                _segment(id: 0, text: 'Resposta', start: 3.0, end: 5.0),
              ])
            : _whisperResponse([
                _segment(id: 0, text: 'Pergunta', start: 0.5, end: 2.5),
              ]);
        return http.Response(
          jsonEncode(body),
          200,
          headers: {'content-type': 'application/json; charset=utf-8'},
        );
      }));

      final result =
          await service.transcribe(callId: 'c-1', audioPath: audioFile.path);

      expect(result[0].speaker, Speaker.remote);
      expect(result[1].speaker, Speaker.local);
    });

    test('empty response returns empty list', () async {
      final service = _service(
        MockClient(
          (_) async => http.Response(
            jsonEncode(_whisperResponse([])),
            200,
            headers: {'content-type': 'application/json; charset=utf-8'},
          ),
        ),
      );

      final result = await service.transcribe(
        callId: 'c-1',
        audioPath: audioFile.path,
      );

      expect(result, isEmpty);
    });

    test('segment timestamps are converted correctly', () async {
      final service = _service(
        MockClient(
          (_) async => http.Response(
            jsonEncode(
              _whisperResponse([
                _segment(id: 0, text: 'Test', start: 1.5, end: 3.75),
              ]),
            ),
            200,
            headers: {'content-type': 'application/json; charset=utf-8'},
          ),
        ),
      );

      final result = await service.transcribe(
        callId: 'c-1',
        audioPath: audioFile.path,
      );

      final seg = result.firstWhere((s) => s.speaker == Speaker.local);
      expect(seg.startAt, const Duration(milliseconds: 1500));
      expect(seg.endAt, const Duration(milliseconds: 3750));
    });
  });
}

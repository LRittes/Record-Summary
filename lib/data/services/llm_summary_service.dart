import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:record_summary/domain/entities/call_summary.dart';
import 'package:record_summary/domain/entities/transcription_segment.dart';
import 'package:record_summary/domain/exceptions/summary_exception.dart';
import 'package:record_summary/domain/services/llm_api_client.dart';
import 'package:record_summary/domain/services/summary_service.dart';

class LlmSummaryService implements SummaryService {
  const LlmSummaryService(this._client, {http.Client? httpClient})
      : _httpClient = httpClient;

  final LlmApiClient _client;
  final http.Client? _httpClient;

  static const _chatUrl = 'https://api.openai.com/v1/chat/completions';
  static const _model = 'gpt-4o';

  http.Client get _http => _httpClient ?? http.Client();

  @override
  Future<CallSummary> summarize({
    required String callId,
    required List<TranscriptionSegment> segments,
  }) async {
    if (segments.isEmpty) {
      return CallSummary(
        callId: callId,
        topics: [],
        tasks: [],
        dates: [],
        negotiations: [],
        rawJson: '{}',
      );
    }

    final transcript = _buildTranscript(segments);
    final response = await _http.post(
      Uri.parse(_chatUrl),
      headers: {
        'Authorization': 'Bearer ${_client.apiKey}',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'model': _model,
        'response_format': {'type': 'json_object'},
        'messages': [
          {'role': 'system', 'content': _systemPrompt()},
          {'role': 'user', 'content': transcript},
        ],
      }),
    );

    if (response.statusCode != 200) {
      throw SummaryException(response.body, statusCode: response.statusCode);
    }

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    final content = decoded['choices'][0]['message']['content'] as String;
    final json = jsonDecode(content) as Map<String, dynamic>;

    return _parse(callId, content, json);
  }

  String _buildTranscript(List<TranscriptionSegment> segments) {
    final buffer = StringBuffer();
    for (final s in segments) {
      final speaker = s.speaker.name.toUpperCase();
      final start = _formatDuration(s.startAt);
      buffer.writeln('[$start] $speaker: ${s.text}');
    }
    return buffer.toString();
  }

  CallSummary _parse(
    String callId,
    String rawJson,
    Map<String, dynamic> json,
  ) {
    return CallSummary(
      callId: callId,
      topics: _parseStringList(json['topics']),
      tasks: _parseStringList(json['tasks']),
      dates: _parseDates(json['dates']),
      negotiations: _parseStringList(json['negotiations']),
      rawJson: rawJson,
    );
  }

  List<String> _parseStringList(dynamic value) {
    if (value is! List) return [];
    return value.whereType<String>().toList();
  }

  List<DateTime> _parseDates(dynamic value) {
    if (value is! List) return [];
    return value
        .whereType<String>()
        .map((s) {
          try {
            return DateTime.parse(s);
          } catch (_) {
            return null;
          }
        })
        .whereType<DateTime>()
        .toList();
  }

  String _formatDuration(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '${d.inHours}:$m:$s';
  }

  String _systemPrompt() => '''
Você é um assistente que analisa transcrições de ligações e extrai informações estruturadas.

Responda APENAS com um objeto JSON válido com a seguinte estrutura:
{
  "topics": ["tópico 1", "tópico 2"],
  "tasks": ["tarefa 1", "tarefa 2"],
  "dates": ["2024-06-15", "2024-07-01"],
  "negotiations": ["negociação 1", "negociação 2"]
}

Regras:
- topics: assuntos principais discutidos na ligação
- tasks: tarefas ou compromissos acordados (quem deve fazer o quê)
- dates: datas mencionadas no formato ISO 8601 (YYYY-MM-DD)
- negotiations: valores, descontos, condições comerciais discutidas
- Se não houver itens para uma categoria, retorne lista vazia
- Responda em português
''';
}
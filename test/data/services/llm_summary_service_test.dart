import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:record_summary/data/services/llm_summary_service.dart';
import 'package:record_summary/domain/entities/transcription_segment.dart';
import 'package:record_summary/domain/exceptions/summary_exception.dart';
import 'package:record_summary/domain/services/llm_api_client.dart';

class _FakeApiClient implements LlmApiClient {
  @override
  String get apiKey => 'test-key';

  @override
  String get baseUrl => 'https://api.openai.com';
}

Map<String, dynamic> _chatResponse(Map<String, dynamic> content) => {
      'id': 'chatcmpl-123',
      'object': 'chat.completion',
      'choices': [
        {
          'index': 0,
          'message': {
            'role': 'assistant',
            'content': jsonEncode(content),
          },
          'finish_reason': 'stop',
        }
      ],
    };

List<TranscriptionSegment> _makeSegments() => [
      TranscriptionSegment(
        id: 's-1',
        callId: 'c-1',
        speaker: Speaker.local,
        text: 'Vamos fechar o contrato na sexta',
        startAt: Duration.zero,
        endAt: const Duration(seconds: 3),
      ),
      TranscriptionSegment(
        id: 's-2',
        callId: 'c-1',
        speaker: Speaker.remote,
        text: 'Concordo, com 10% de desconto',
        startAt: const Duration(seconds: 3),
        endAt: const Duration(seconds: 6),
      ),
    ];

LlmSummaryService _service(http.Client mockHttp) =>
    LlmSummaryService(_FakeApiClient(), httpClient: mockHttp);

void main() {
  group('LlmSummaryService', () {
    test('returns empty summary when segments is empty', () async {
      final service = _service(MockClient((_) async => http.Response('', 200)));
      final result = await service.summarize(callId: 'c-1', segments: []);

      expect(result.topics, isEmpty);
      expect(result.tasks, isEmpty);
      expect(result.dates, isEmpty);
      expect(result.negotiations, isEmpty);
    });

    test('throws SummaryException on non-200 response', () {
      final service = _service(MockClient(
        (_) async => http.Response('{"error":"unauthorized"}', 401),
      ));
      expect(
        () => service.summarize(callId: 'c-1', segments: _makeSegments()),
        throwsA(isA<SummaryException>().having(
          (e) => e.statusCode,
          'statusCode',
          401,
        )),
      );
    });

    test('parses topics, tasks, dates and negotiations correctly', () async {
      final service = _service(MockClient(
        (_) async => http.Response(
          jsonEncode(_chatResponse({
            'topics': ['Fechamento de contrato'],
            'tasks': ['Enviar contrato ate sexta'],
            'dates': ['2024-06-14'],
            'negotiations': ['Desconto de 10%'],
          })),
          200,
          headers: {'content-type': 'application/json; charset=utf-8'},
        ),
      ));

      final result =
          await service.summarize(callId: 'c-1', segments: _makeSegments());

      expect(result.callId, 'c-1');
      expect(result.topics, contains('Fechamento de contrato'));
      expect(result.tasks, contains('Enviar contrato ate sexta'));
      expect(result.dates, contains(DateTime(2024, 6, 14)));
      expect(result.negotiations, contains('Desconto de 10%'));
    });

    test('handles missing keys in response gracefully', () async {
      final service = _service(MockClient(
        (_) async => http.Response(
          jsonEncode(_chatResponse({})),
          200,
          headers: {'content-type': 'application/json; charset=utf-8'},
        ),
      ));

      final result =
          await service.summarize(callId: 'c-1', segments: _makeSegments());

      expect(result.topics, isEmpty);
      expect(result.tasks, isEmpty);
      expect(result.dates, isEmpty);
      expect(result.negotiations, isEmpty);
    });

    test('skips unparseable dates without throwing', () async {
      final service = _service(MockClient(
        (_) async => http.Response(
          jsonEncode(_chatResponse({
            'topics': [],
            'tasks': [],
            'dates': ['not-a-date', '2024-06-14'],
            'negotiations': [],
          })),
          200,
          headers: {'content-type': 'application/json; charset=utf-8'},
        ),
      ));

      final result =
          await service.summarize(callId: 'c-1', segments: _makeSegments());

      expect(result.dates.length, 1);
      expect(result.dates.first, DateTime(2024, 6, 14));
    });

    test('rawJson contains the original response content', () async {
      final content = {
        'topics': ['Teste'],
        'tasks': [],
        'dates': [],
        'negotiations': [],
      };
      final service = _service(MockClient(
        (_) async => http.Response(
          jsonEncode(_chatResponse(content)),
          200,
          headers: {'content-type': 'application/json; charset=utf-8'},
        ),
      ));

      final result =
          await service.summarize(callId: 'c-1', segments: _makeSegments());

      expect(result.rawJson, jsonEncode(content));
    });
  });
}
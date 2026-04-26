import 'package:flutter_test/flutter_test.dart';
import 'package:record_summary/domain/entities/call.dart';
import 'package:record_summary/domain/entities/call_summary.dart';
import 'package:record_summary/domain/entities/transcription_segment.dart';
import 'package:record_summary/domain/enums/call_type.dart';
import 'package:record_summary/domain/enums/recording_status.dart';
import 'package:record_summary/domain/exceptions/summary_exception.dart';
import 'package:record_summary/domain/exceptions/transcription_exception.dart';
import 'package:record_summary/domain/repositories/repositories.dart';
import 'package:record_summary/domain/services/call_orchestrator.dart';
import 'package:record_summary/domain/services/summary_service.dart';
import 'package:record_summary/domain/services/transcription_service.dart';

// ──────────────────────────────────────────
// Fakes
// ──────────────────────────────────────────

class _FakeCallRepository implements CallRepository {
  final List<Call> _calls = [];
  final List<Call> updates = [];

  @override
  Future<void> save(Call call) async => _calls.add(call);

  @override
  Future<void> update(Call call) async => updates.add(call);

  @override
  Future<Call?> findById(String id) async =>
      _calls.cast<Call?>().firstWhere((c) => c?.id == id, orElse: () => null);

  @override
  Future<List<Call>> findAll() async => List.unmodifiable(_calls);
}

class _FakeTranscriptionRepository implements TranscriptionRepository {
  final List<List<TranscriptionSegment>> saved = [];

  @override
  Future<void> saveSegments(List<TranscriptionSegment> segments) async =>
      saved.add(segments);

  @override
  Future<List<TranscriptionSegment>> findByCallId(String callId) async => [];
}

class _FakeSummaryRepository implements SummaryRepository {
  final List<CallSummary> saved = [];

  @override
  Future<void> save(CallSummary summary) async => saved.add(summary);

  @override
  Future<CallSummary?> findByCallId(String callId) async => null;
}

class _FakeTranscriptionService implements TranscriptionService {
  final List<TranscriptionSegment> segments;
  final Exception? error;

  _FakeTranscriptionService({this.segments = const [], this.error});

  @override
  Future<List<TranscriptionSegment>> transcribe({
    required String callId,
    required String audioPath,
  }) async {
    if (error != null) throw error!;
    return segments;
  }
}

class _FakeSummaryService implements SummaryService {
  final CallSummary? summary;
  final Exception? error;

  _FakeSummaryService({this.summary, this.error});

  @override
  Future<CallSummary> summarize({
    required String callId,
    required List<TranscriptionSegment> segments,
  }) async {
    if (error != null) throw error!;
    return summary ??
        CallSummary(
          callId: callId,
          topics: [],
          tasks: [],
          dates: [],
          negotiations: [],
          rawJson: '{}',
        );
  }
}

// ──────────────────────────────────────────
// Helpers
// ──────────────────────────────────────────

Call _makeCall() => Call(
      id: 'c-1',
      startedAt: DateTime(2024, 1, 1, 10, 0),
      endedAt: DateTime(2024, 1, 1, 10, 5),
      type: CallType.whatsappVoice,
      audioPath: '/audio/c-1.m4a',
      status: RecordingStatus.recording,
    );

List<TranscriptionSegment> _makeSegments() => [
      TranscriptionSegment(
        id: 's-1',
        callId: 'c-1',
        speaker: Speaker.local,
        text: 'Ola',
        startAt: Duration.zero,
        endAt: const Duration(seconds: 1),
      ),
    ];

CallOrchestrator _makeOrchestrator({
  _FakeCallRepository? callRepo,
  _FakeTranscriptionRepository? transcriptionRepo,
  _FakeSummaryRepository? summaryRepo,
  TranscriptionService? transcriptionService,
  SummaryService? summaryService,
}) =>
    CallOrchestrator(
      callRepository: callRepo ?? _FakeCallRepository(),
      transcriptionRepository: transcriptionRepo ?? _FakeTranscriptionRepository(),
      summaryRepository: summaryRepo ?? _FakeSummaryRepository(),
      transcriptionService: transcriptionService ??
          _FakeTranscriptionService(segments: _makeSegments()),
      summaryService: summaryService ?? _FakeSummaryService(),
    );

// ──────────────────────────────────────────
// Tests
// ──────────────────────────────────────────

void main() {
  group('CallOrchestrator', () {
    test('happy path: updates status to processing → transcribed → summarized',
        () async {
      final callRepo = _FakeCallRepository();
      final orchestrator = _makeOrchestrator(
        callRepo: callRepo,
        transcriptionService:
            _FakeTranscriptionService(segments: _makeSegments()),
      );

      await orchestrator.process(_makeCall());

      expect(callRepo.updates.length, 3);
      expect(callRepo.updates[0].status, RecordingStatus.processing);
      expect(callRepo.updates[1].status, RecordingStatus.transcribed);
      expect(callRepo.updates[2].status, RecordingStatus.summarized);
    });

    test('saves transcription segments', () async {
      final transcriptionRepo = _FakeTranscriptionRepository();
      final orchestrator = _makeOrchestrator(
        transcriptionRepo: transcriptionRepo,
        transcriptionService:
            _FakeTranscriptionService(segments: _makeSegments()),
      );

      await orchestrator.process(_makeCall());

      expect(transcriptionRepo.saved.length, 1);
      expect(transcriptionRepo.saved.first.length, 1);
    });

    test('saves summary', () async {
      final summaryRepo = _FakeSummaryRepository();
      final orchestrator = _makeOrchestrator(summaryRepo: summaryRepo);

      await orchestrator.process(_makeCall());

      expect(summaryRepo.saved.length, 1);
      expect(summaryRepo.saved.first.callId, 'c-1');
    });

    test('sets status to failed and rethrows on TranscriptionException',
        () async {
      final callRepo = _FakeCallRepository();
      final orchestrator = _makeOrchestrator(
        callRepo: callRepo,
        transcriptionService: _FakeTranscriptionService(
          error: const TranscriptionException('whisper error'),
        ),
      );

      expect(
        () => orchestrator.process(_makeCall()),
        throwsA(isA<TranscriptionException>()),
      );

      await Future.delayed(Duration.zero);
      expect(callRepo.updates.last.status, RecordingStatus.failed);
    });

    test('sets status to failed and rethrows on SummaryException', () async {
      final callRepo = _FakeCallRepository();
      final orchestrator = _makeOrchestrator(
        callRepo: callRepo,
        transcriptionService:
            _FakeTranscriptionService(segments: _makeSegments()),
        summaryService: _FakeSummaryService(
          error: const SummaryException('llm error'),
        ),
      );

      expect(
        () => orchestrator.process(_makeCall()),
        throwsA(isA<SummaryException>()),
      );

      await Future.delayed(Duration.zero);
      expect(callRepo.updates.last.status, RecordingStatus.failed);
    });
  });
}
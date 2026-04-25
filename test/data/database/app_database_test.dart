import 'package:record_summary/data/database/app_database.dart';
import 'package:record_summary/data/database/daos.dart';
import 'package:record_summary/domain/entities/call.dart';
import 'package:record_summary/domain/entities/call_summary.dart';
import 'package:record_summary/domain/entities/transcription_segment.dart';
import 'package:record_summary/domain/enums/call_type.dart';
import 'package:record_summary/domain/enums/recording_status.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

AppDatabase _inMemoryDb() => AppDatabase.forTesting(NativeDatabase.memory());

Call _makeCall({String id = 'call-1'}) => Call(
      id: id,
      startedAt: DateTime(2024, 1, 1, 10, 0),
      type: CallType.whatsappVoice,
      audioPath: '/audio/$id.m4a',
      status: RecordingStatus.recording,
    );

void main() {
  group('Call entity', () {
    test('duration is null when endedAt is null', () {
      expect(_makeCall().duration, isNull);
    });

    test('duration is computed when endedAt is set', () {
      final call = _makeCall().copyWith(endedAt: DateTime(2024, 1, 1, 10, 5));
      expect(call.duration, const Duration(minutes: 5));
    });

    test('copyWith preserves unchanged fields', () {
      final original = _makeCall();
      final updated = original.copyWith(status: RecordingStatus.transcribed);
      expect(updated.id, original.id);
      expect(updated.type, original.type);
      expect(updated.status, RecordingStatus.transcribed);
    });
  });

  group('CallDao', () {
    late AppDatabase db;
    late CallDao dao;

    setUp(() {
      db = _inMemoryDb();
      dao = CallDao(db);
    });

    tearDown(() => db.close());

    test('save and findById', () async {
      final call = _makeCall();
      await dao.save(call);
      final found = await dao.findById(call.id);
      expect(found, isNotNull);
      expect(found!.id, call.id);
      expect(found.type, CallType.whatsappVoice);
      expect(found.status, RecordingStatus.recording);
    });

    test('update persists new status', () async {
      await dao.save(_makeCall());
      final updated = _makeCall().copyWith(status: RecordingStatus.summarized);
      await dao.update(updated);
      final found = await dao.findById('call-1');
      expect(found!.status, RecordingStatus.summarized);
    });

    test('findAll returns all saved calls', () async {
      await dao.save(_makeCall(id: 'a'));
      await dao.save(_makeCall(id: 'b'));
      final all = await dao.findAll();
      expect(all.length, 2);
    });

    test('findById returns null for unknown id', () async {
      expect(await dao.findById('nonexistent'), isNull);
    });
  });

  group('TranscriptionDao', () {
    late AppDatabase db;
    late TranscriptionDao dao;

    setUp(() async {
      db = _inMemoryDb();
      dao = TranscriptionDao(db);
      await CallDao(db).save(_makeCall());
    });

    tearDown(() => db.close());

    test('saveSegments and findByCallId', () async {
      final segments = [
        TranscriptionSegment(
          id: 's-1',
          callId: 'call-1',
          speaker: Speaker.local,
          text: 'Olá, tudo bem?',
          startAt: Duration.zero,
          endAt: const Duration(seconds: 2),
        ),
        TranscriptionSegment(
          id: 's-2',
          callId: 'call-1',
          speaker: Speaker.remote,
          text: 'Tudo ótimo!',
          startAt: const Duration(seconds: 2),
          endAt: const Duration(seconds: 4),
        ),
      ];
      await dao.saveSegments(segments);
      final found = await dao.findByCallId('call-1');
      expect(found.length, 2);
      expect(found[0].speaker, Speaker.local);
      expect(found[1].text, 'Tudo ótimo!');
    });

    test('findByCallId returns empty for unknown callId', () async {
      expect(await dao.findByCallId('none'), isEmpty);
    });
  });

  group('SummaryDao', () {
    late AppDatabase db;
    late SummaryDao dao;

    setUp(() async {
      db = _inMemoryDb();
      dao = SummaryDao(db);
      await CallDao(db).save(_makeCall());
    });

    tearDown(() => db.close());

    test('save and findByCallId', () async {
      final summary = CallSummary(
        callId: 'call-1',
        topics: ['Proposta comercial', 'Prazo de entrega'],
        tasks: ['Enviar contrato até sexta'],
        dates: [DateTime(2024, 6, 15)],
        negotiations: ['Desconto de 10%'],
        rawJson: '{}',
      );
      await dao.save(summary);
      final found = await dao.findByCallId('call-1');
      expect(found, isNotNull);
      expect(found!.topics, contains('Proposta comercial'));
      expect(found.tasks, contains('Enviar contrato até sexta'));
      expect(found.dates.first, DateTime(2024, 6, 15));
      expect(found.negotiations, contains('Desconto de 10%'));
    });

    test('save twice (upsert) does not throw', () async {
      final summary = CallSummary(
        callId: 'call-1',
        topics: ['v1'],
        tasks: [],
        dates: [],
        negotiations: [],
        rawJson: '{}',
      );
      await dao.save(summary);
      await dao.save(summary); // upsert
    });

    test('findByCallId returns null for unknown callId', () async {
      expect(await dao.findByCallId('none'), isNull);
    });
  });
}
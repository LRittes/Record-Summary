import 'dart:convert';

import 'package:record_summary/data/database/app_database.dart';
import 'package:record_summary/domain/entities/call.dart';
import 'package:record_summary/domain/entities/call_summary.dart';
import 'package:record_summary/domain/entities/transcription_segment.dart';
import 'package:record_summary/domain/enums/call_type.dart';
import 'package:record_summary/domain/enums/recording_status.dart';
import 'package:record_summary/domain/repositories/repositories.dart';
import 'package:drift/drift.dart';

class CallDao implements CallRepository {
  const CallDao(this._db);

  final AppDatabase _db;

  @override
  Future<void> save(Call call) =>
      _db.into(_db.callsTable).insert(_toCompanion(call));

  @override
  Future<void> update(Call call) =>
      (_db.update(_db.callsTable)..where((t) => t.id.equals(call.id)))
          .write(_toCompanion(call));

  @override
  Future<Call?> findById(String id) async {
    final row = await (_db.select(_db.callsTable)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return row != null ? _toDomain(row) : null;
  }

  @override
  Future<List<Call>> findAll() async {
    final rows = await _db.select(_db.callsTable).get();
    return rows.map(_toDomain).toList();
  }

  CallsTableCompanion _toCompanion(Call c) => CallsTableCompanion(
        id: Value(c.id),
        startedAt: Value(c.startedAt),
        endedAt: Value(c.endedAt),
        type: Value(c.type.index),
        audioPath: Value(c.audioPath),
        status: Value(c.status.index),
      );

  Call _toDomain(CallsTableData r) => Call(
        id: r.id,
        startedAt: r.startedAt,
        endedAt: r.endedAt,
        type: CallType.values[r.type],
        audioPath: r.audioPath,
        status: RecordingStatus.values[r.status],
      );
}

class TranscriptionDao implements TranscriptionRepository {
  const TranscriptionDao(this._db);

  final AppDatabase _db;

  @override
  Future<void> saveSegments(List<TranscriptionSegment> segments) async {
    await _db.batch((b) => b.insertAll(
          _db.transcriptionSegmentsTable,
          segments.map(_toCompanion).toList(),
        ));
  }

  @override
  Future<List<TranscriptionSegment>> findByCallId(String callId) async {
    final rows = await (_db.select(_db.transcriptionSegmentsTable)
          ..where((t) => t.callId.equals(callId)))
        .get();
    return rows.map(_toDomain).toList();
  }

  TranscriptionSegmentsTableCompanion _toCompanion(TranscriptionSegment s) =>
    TranscriptionSegmentsTableCompanion(
      id: Value(s.id),
      callId: Value(s.callId),
      speaker: Value(s.speaker.index),
      content: Value(s.text),  // era: text: Value(s.text)
      startMs: Value(s.startAt.inMilliseconds),
      endMs: Value(s.endAt.inMilliseconds),
    );

  TranscriptionSegment _toDomain(TranscriptionSegmentsTableData r) =>
      TranscriptionSegment(
        id: r.id,
        callId: r.callId,
        speaker: Speaker.values[r.speaker],
        text: r.content,  // era: text: r.text
        startAt: Duration(milliseconds: r.startMs),
        endAt: Duration(milliseconds: r.endMs),
      );
}

class SummaryDao implements SummaryRepository {
  const SummaryDao(this._db);

  final AppDatabase _db;

  @override
  Future<void> save(CallSummary summary) =>
      _db.into(_db.summariesTable).insertOnConflictUpdate(
            SummariesTableCompanion(
              callId: Value(summary.callId),
              topicsJson: Value(jsonEncode(summary.topics)),
              tasksJson: Value(jsonEncode(summary.tasks)),
              datesJson: Value(jsonEncode(
                  summary.dates.map((d) => d.toIso8601String()).toList())),
              negotiationsJson: Value(jsonEncode(summary.negotiations)),
              rawJson: Value(summary.rawJson),
            ),
          );

  @override
  Future<CallSummary?> findByCallId(String callId) async {
    final row = await (_db.select(_db.summariesTable)
          ..where((t) => t.callId.equals(callId)))
        .getSingleOrNull();
    if (row == null) return null;
    return CallSummary(
      callId: row.callId,
      topics: List<String>.from(jsonDecode(row.topicsJson)),
      tasks: List<String>.from(jsonDecode(row.tasksJson)),
      dates: (jsonDecode(row.datesJson) as List)
          .map((s) => DateTime.parse(s as String))
          .toList(),
      negotiations: List<String>.from(jsonDecode(row.negotiationsJson)),
      rawJson: row.rawJson,
    );
  }
}
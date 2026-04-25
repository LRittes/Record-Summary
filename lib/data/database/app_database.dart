import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

class CallsTable extends Table {
  TextColumn get id => text()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get endedAt => dateTime().nullable()();
  IntColumn get type => integer()();
  TextColumn get audioPath => text()();
  IntColumn get status => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

class TranscriptionSegmentsTable extends Table {
  TextColumn get id => text()();
  TextColumn get callId => text().references(CallsTable, #id)();
  IntColumn get speaker => integer()();
  TextColumn get content => text()();  // renomeado de "text" para "content"
  IntColumn get startMs => integer()();
  IntColumn get endMs => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

class SummariesTable extends Table {
  TextColumn get callId => text().references(CallsTable, #id)();
  TextColumn get topicsJson => text()();
  TextColumn get tasksJson => text()();
  TextColumn get datesJson => text()();
  TextColumn get negotiationsJson => text()();
  TextColumn get rawJson => text()();

  @override
  Set<Column> get primaryKey => {callId};
}

@DriftDatabase(tables: [CallsTable, TranscriptionSegmentsTable, SummariesTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() => LazyDatabase(() async {
      final dir = await getApplicationDocumentsDirectory();
      final file = File(p.join(dir.path, 'record_summary.db'));
      return NativeDatabase.createInBackground(file);
    });
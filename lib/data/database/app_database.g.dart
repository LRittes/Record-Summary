// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CallsTableTable extends CallsTable
    with TableInfo<$CallsTableTable, CallsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CallsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endedAtMeta = const VerificationMeta(
    'endedAt',
  );
  @override
  late final GeneratedColumn<DateTime> endedAt = GeneratedColumn<DateTime>(
    'ended_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<int> type = GeneratedColumn<int>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _audioPathMeta = const VerificationMeta(
    'audioPath',
  );
  @override
  late final GeneratedColumn<String> audioPath = GeneratedColumn<String>(
    'audio_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<int> status = GeneratedColumn<int>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    startedAt,
    endedAt,
    type,
    audioPath,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'calls_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<CallsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('ended_at')) {
      context.handle(
        _endedAtMeta,
        endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta),
      );
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('audio_path')) {
      context.handle(
        _audioPathMeta,
        audioPath.isAcceptableOrUnknown(data['audio_path']!, _audioPathMeta),
      );
    } else if (isInserting) {
      context.missing(_audioPathMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CallsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CallsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ended_at'],
      ),
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}type'],
      )!,
      audioPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}audio_path'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}status'],
      )!,
    );
  }

  @override
  $CallsTableTable createAlias(String alias) {
    return $CallsTableTable(attachedDatabase, alias);
  }
}

class CallsTableData extends DataClass implements Insertable<CallsTableData> {
  final String id;
  final DateTime startedAt;
  final DateTime? endedAt;
  final int type;
  final String audioPath;
  final int status;
  const CallsTableData({
    required this.id,
    required this.startedAt,
    this.endedAt,
    required this.type,
    required this.audioPath,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || endedAt != null) {
      map['ended_at'] = Variable<DateTime>(endedAt);
    }
    map['type'] = Variable<int>(type);
    map['audio_path'] = Variable<String>(audioPath);
    map['status'] = Variable<int>(status);
    return map;
  }

  CallsTableCompanion toCompanion(bool nullToAbsent) {
    return CallsTableCompanion(
      id: Value(id),
      startedAt: Value(startedAt),
      endedAt: endedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endedAt),
      type: Value(type),
      audioPath: Value(audioPath),
      status: Value(status),
    );
  }

  factory CallsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CallsTableData(
      id: serializer.fromJson<String>(json['id']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      endedAt: serializer.fromJson<DateTime?>(json['endedAt']),
      type: serializer.fromJson<int>(json['type']),
      audioPath: serializer.fromJson<String>(json['audioPath']),
      status: serializer.fromJson<int>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'endedAt': serializer.toJson<DateTime?>(endedAt),
      'type': serializer.toJson<int>(type),
      'audioPath': serializer.toJson<String>(audioPath),
      'status': serializer.toJson<int>(status),
    };
  }

  CallsTableData copyWith({
    String? id,
    DateTime? startedAt,
    Value<DateTime?> endedAt = const Value.absent(),
    int? type,
    String? audioPath,
    int? status,
  }) => CallsTableData(
    id: id ?? this.id,
    startedAt: startedAt ?? this.startedAt,
    endedAt: endedAt.present ? endedAt.value : this.endedAt,
    type: type ?? this.type,
    audioPath: audioPath ?? this.audioPath,
    status: status ?? this.status,
  );
  CallsTableData copyWithCompanion(CallsTableCompanion data) {
    return CallsTableData(
      id: data.id.present ? data.id.value : this.id,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
      type: data.type.present ? data.type.value : this.type,
      audioPath: data.audioPath.present ? data.audioPath.value : this.audioPath,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CallsTableData(')
          ..write('id: $id, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('type: $type, ')
          ..write('audioPath: $audioPath, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, startedAt, endedAt, type, audioPath, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CallsTableData &&
          other.id == this.id &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt &&
          other.type == this.type &&
          other.audioPath == this.audioPath &&
          other.status == this.status);
}

class CallsTableCompanion extends UpdateCompanion<CallsTableData> {
  final Value<String> id;
  final Value<DateTime> startedAt;
  final Value<DateTime?> endedAt;
  final Value<int> type;
  final Value<String> audioPath;
  final Value<int> status;
  final Value<int> rowid;
  const CallsTableCompanion({
    this.id = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.type = const Value.absent(),
    this.audioPath = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CallsTableCompanion.insert({
    required String id,
    required DateTime startedAt,
    this.endedAt = const Value.absent(),
    required int type,
    required String audioPath,
    required int status,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       startedAt = Value(startedAt),
       type = Value(type),
       audioPath = Value(audioPath),
       status = Value(status);
  static Insertable<CallsTableData> custom({
    Expression<String>? id,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? endedAt,
    Expression<int>? type,
    Expression<String>? audioPath,
    Expression<int>? status,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
      if (type != null) 'type': type,
      if (audioPath != null) 'audio_path': audioPath,
      if (status != null) 'status': status,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CallsTableCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? startedAt,
    Value<DateTime?>? endedAt,
    Value<int>? type,
    Value<String>? audioPath,
    Value<int>? status,
    Value<int>? rowid,
  }) {
    return CallsTableCompanion(
      id: id ?? this.id,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      type: type ?? this.type,
      audioPath: audioPath ?? this.audioPath,
      status: status ?? this.status,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(type.value);
    }
    if (audioPath.present) {
      map['audio_path'] = Variable<String>(audioPath.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(status.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CallsTableCompanion(')
          ..write('id: $id, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('type: $type, ')
          ..write('audioPath: $audioPath, ')
          ..write('status: $status, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TranscriptionSegmentsTableTable extends TranscriptionSegmentsTable
    with
        TableInfo<
          $TranscriptionSegmentsTableTable,
          TranscriptionSegmentsTableData
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TranscriptionSegmentsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _callIdMeta = const VerificationMeta('callId');
  @override
  late final GeneratedColumn<String> callId = GeneratedColumn<String>(
    'call_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES calls_table (id)',
    ),
  );
  static const VerificationMeta _speakerMeta = const VerificationMeta(
    'speaker',
  );
  @override
  late final GeneratedColumn<int> speaker = GeneratedColumn<int>(
    'speaker',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startMsMeta = const VerificationMeta(
    'startMs',
  );
  @override
  late final GeneratedColumn<int> startMs = GeneratedColumn<int>(
    'start_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endMsMeta = const VerificationMeta('endMs');
  @override
  late final GeneratedColumn<int> endMs = GeneratedColumn<int>(
    'end_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    callId,
    speaker,
    content,
    startMs,
    endMs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transcription_segments_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<TranscriptionSegmentsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('call_id')) {
      context.handle(
        _callIdMeta,
        callId.isAcceptableOrUnknown(data['call_id']!, _callIdMeta),
      );
    } else if (isInserting) {
      context.missing(_callIdMeta);
    }
    if (data.containsKey('speaker')) {
      context.handle(
        _speakerMeta,
        speaker.isAcceptableOrUnknown(data['speaker']!, _speakerMeta),
      );
    } else if (isInserting) {
      context.missing(_speakerMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('start_ms')) {
      context.handle(
        _startMsMeta,
        startMs.isAcceptableOrUnknown(data['start_ms']!, _startMsMeta),
      );
    } else if (isInserting) {
      context.missing(_startMsMeta);
    }
    if (data.containsKey('end_ms')) {
      context.handle(
        _endMsMeta,
        endMs.isAcceptableOrUnknown(data['end_ms']!, _endMsMeta),
      );
    } else if (isInserting) {
      context.missing(_endMsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TranscriptionSegmentsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TranscriptionSegmentsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      callId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}call_id'],
      )!,
      speaker: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}speaker'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      startMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}start_ms'],
      )!,
      endMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}end_ms'],
      )!,
    );
  }

  @override
  $TranscriptionSegmentsTableTable createAlias(String alias) {
    return $TranscriptionSegmentsTableTable(attachedDatabase, alias);
  }
}

class TranscriptionSegmentsTableData extends DataClass
    implements Insertable<TranscriptionSegmentsTableData> {
  final String id;
  final String callId;
  final int speaker;
  final String content;
  final int startMs;
  final int endMs;
  const TranscriptionSegmentsTableData({
    required this.id,
    required this.callId,
    required this.speaker,
    required this.content,
    required this.startMs,
    required this.endMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['call_id'] = Variable<String>(callId);
    map['speaker'] = Variable<int>(speaker);
    map['content'] = Variable<String>(content);
    map['start_ms'] = Variable<int>(startMs);
    map['end_ms'] = Variable<int>(endMs);
    return map;
  }

  TranscriptionSegmentsTableCompanion toCompanion(bool nullToAbsent) {
    return TranscriptionSegmentsTableCompanion(
      id: Value(id),
      callId: Value(callId),
      speaker: Value(speaker),
      content: Value(content),
      startMs: Value(startMs),
      endMs: Value(endMs),
    );
  }

  factory TranscriptionSegmentsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TranscriptionSegmentsTableData(
      id: serializer.fromJson<String>(json['id']),
      callId: serializer.fromJson<String>(json['callId']),
      speaker: serializer.fromJson<int>(json['speaker']),
      content: serializer.fromJson<String>(json['content']),
      startMs: serializer.fromJson<int>(json['startMs']),
      endMs: serializer.fromJson<int>(json['endMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'callId': serializer.toJson<String>(callId),
      'speaker': serializer.toJson<int>(speaker),
      'content': serializer.toJson<String>(content),
      'startMs': serializer.toJson<int>(startMs),
      'endMs': serializer.toJson<int>(endMs),
    };
  }

  TranscriptionSegmentsTableData copyWith({
    String? id,
    String? callId,
    int? speaker,
    String? content,
    int? startMs,
    int? endMs,
  }) => TranscriptionSegmentsTableData(
    id: id ?? this.id,
    callId: callId ?? this.callId,
    speaker: speaker ?? this.speaker,
    content: content ?? this.content,
    startMs: startMs ?? this.startMs,
    endMs: endMs ?? this.endMs,
  );
  TranscriptionSegmentsTableData copyWithCompanion(
    TranscriptionSegmentsTableCompanion data,
  ) {
    return TranscriptionSegmentsTableData(
      id: data.id.present ? data.id.value : this.id,
      callId: data.callId.present ? data.callId.value : this.callId,
      speaker: data.speaker.present ? data.speaker.value : this.speaker,
      content: data.content.present ? data.content.value : this.content,
      startMs: data.startMs.present ? data.startMs.value : this.startMs,
      endMs: data.endMs.present ? data.endMs.value : this.endMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TranscriptionSegmentsTableData(')
          ..write('id: $id, ')
          ..write('callId: $callId, ')
          ..write('speaker: $speaker, ')
          ..write('content: $content, ')
          ..write('startMs: $startMs, ')
          ..write('endMs: $endMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, callId, speaker, content, startMs, endMs);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TranscriptionSegmentsTableData &&
          other.id == this.id &&
          other.callId == this.callId &&
          other.speaker == this.speaker &&
          other.content == this.content &&
          other.startMs == this.startMs &&
          other.endMs == this.endMs);
}

class TranscriptionSegmentsTableCompanion
    extends UpdateCompanion<TranscriptionSegmentsTableData> {
  final Value<String> id;
  final Value<String> callId;
  final Value<int> speaker;
  final Value<String> content;
  final Value<int> startMs;
  final Value<int> endMs;
  final Value<int> rowid;
  const TranscriptionSegmentsTableCompanion({
    this.id = const Value.absent(),
    this.callId = const Value.absent(),
    this.speaker = const Value.absent(),
    this.content = const Value.absent(),
    this.startMs = const Value.absent(),
    this.endMs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TranscriptionSegmentsTableCompanion.insert({
    required String id,
    required String callId,
    required int speaker,
    required String content,
    required int startMs,
    required int endMs,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       callId = Value(callId),
       speaker = Value(speaker),
       content = Value(content),
       startMs = Value(startMs),
       endMs = Value(endMs);
  static Insertable<TranscriptionSegmentsTableData> custom({
    Expression<String>? id,
    Expression<String>? callId,
    Expression<int>? speaker,
    Expression<String>? content,
    Expression<int>? startMs,
    Expression<int>? endMs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (callId != null) 'call_id': callId,
      if (speaker != null) 'speaker': speaker,
      if (content != null) 'content': content,
      if (startMs != null) 'start_ms': startMs,
      if (endMs != null) 'end_ms': endMs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TranscriptionSegmentsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? callId,
    Value<int>? speaker,
    Value<String>? content,
    Value<int>? startMs,
    Value<int>? endMs,
    Value<int>? rowid,
  }) {
    return TranscriptionSegmentsTableCompanion(
      id: id ?? this.id,
      callId: callId ?? this.callId,
      speaker: speaker ?? this.speaker,
      content: content ?? this.content,
      startMs: startMs ?? this.startMs,
      endMs: endMs ?? this.endMs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (callId.present) {
      map['call_id'] = Variable<String>(callId.value);
    }
    if (speaker.present) {
      map['speaker'] = Variable<int>(speaker.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (startMs.present) {
      map['start_ms'] = Variable<int>(startMs.value);
    }
    if (endMs.present) {
      map['end_ms'] = Variable<int>(endMs.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TranscriptionSegmentsTableCompanion(')
          ..write('id: $id, ')
          ..write('callId: $callId, ')
          ..write('speaker: $speaker, ')
          ..write('content: $content, ')
          ..write('startMs: $startMs, ')
          ..write('endMs: $endMs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SummariesTableTable extends SummariesTable
    with TableInfo<$SummariesTableTable, SummariesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SummariesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _callIdMeta = const VerificationMeta('callId');
  @override
  late final GeneratedColumn<String> callId = GeneratedColumn<String>(
    'call_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES calls_table (id)',
    ),
  );
  static const VerificationMeta _topicsJsonMeta = const VerificationMeta(
    'topicsJson',
  );
  @override
  late final GeneratedColumn<String> topicsJson = GeneratedColumn<String>(
    'topics_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tasksJsonMeta = const VerificationMeta(
    'tasksJson',
  );
  @override
  late final GeneratedColumn<String> tasksJson = GeneratedColumn<String>(
    'tasks_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _datesJsonMeta = const VerificationMeta(
    'datesJson',
  );
  @override
  late final GeneratedColumn<String> datesJson = GeneratedColumn<String>(
    'dates_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _negotiationsJsonMeta = const VerificationMeta(
    'negotiationsJson',
  );
  @override
  late final GeneratedColumn<String> negotiationsJson = GeneratedColumn<String>(
    'negotiations_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rawJsonMeta = const VerificationMeta(
    'rawJson',
  );
  @override
  late final GeneratedColumn<String> rawJson = GeneratedColumn<String>(
    'raw_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    callId,
    topicsJson,
    tasksJson,
    datesJson,
    negotiationsJson,
    rawJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'summaries_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<SummariesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('call_id')) {
      context.handle(
        _callIdMeta,
        callId.isAcceptableOrUnknown(data['call_id']!, _callIdMeta),
      );
    } else if (isInserting) {
      context.missing(_callIdMeta);
    }
    if (data.containsKey('topics_json')) {
      context.handle(
        _topicsJsonMeta,
        topicsJson.isAcceptableOrUnknown(data['topics_json']!, _topicsJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_topicsJsonMeta);
    }
    if (data.containsKey('tasks_json')) {
      context.handle(
        _tasksJsonMeta,
        tasksJson.isAcceptableOrUnknown(data['tasks_json']!, _tasksJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_tasksJsonMeta);
    }
    if (data.containsKey('dates_json')) {
      context.handle(
        _datesJsonMeta,
        datesJson.isAcceptableOrUnknown(data['dates_json']!, _datesJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_datesJsonMeta);
    }
    if (data.containsKey('negotiations_json')) {
      context.handle(
        _negotiationsJsonMeta,
        negotiationsJson.isAcceptableOrUnknown(
          data['negotiations_json']!,
          _negotiationsJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_negotiationsJsonMeta);
    }
    if (data.containsKey('raw_json')) {
      context.handle(
        _rawJsonMeta,
        rawJson.isAcceptableOrUnknown(data['raw_json']!, _rawJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_rawJsonMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {callId};
  @override
  SummariesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SummariesTableData(
      callId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}call_id'],
      )!,
      topicsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}topics_json'],
      )!,
      tasksJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tasks_json'],
      )!,
      datesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dates_json'],
      )!,
      negotiationsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}negotiations_json'],
      )!,
      rawJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}raw_json'],
      )!,
    );
  }

  @override
  $SummariesTableTable createAlias(String alias) {
    return $SummariesTableTable(attachedDatabase, alias);
  }
}

class SummariesTableData extends DataClass
    implements Insertable<SummariesTableData> {
  final String callId;
  final String topicsJson;
  final String tasksJson;
  final String datesJson;
  final String negotiationsJson;
  final String rawJson;
  const SummariesTableData({
    required this.callId,
    required this.topicsJson,
    required this.tasksJson,
    required this.datesJson,
    required this.negotiationsJson,
    required this.rawJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['call_id'] = Variable<String>(callId);
    map['topics_json'] = Variable<String>(topicsJson);
    map['tasks_json'] = Variable<String>(tasksJson);
    map['dates_json'] = Variable<String>(datesJson);
    map['negotiations_json'] = Variable<String>(negotiationsJson);
    map['raw_json'] = Variable<String>(rawJson);
    return map;
  }

  SummariesTableCompanion toCompanion(bool nullToAbsent) {
    return SummariesTableCompanion(
      callId: Value(callId),
      topicsJson: Value(topicsJson),
      tasksJson: Value(tasksJson),
      datesJson: Value(datesJson),
      negotiationsJson: Value(negotiationsJson),
      rawJson: Value(rawJson),
    );
  }

  factory SummariesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SummariesTableData(
      callId: serializer.fromJson<String>(json['callId']),
      topicsJson: serializer.fromJson<String>(json['topicsJson']),
      tasksJson: serializer.fromJson<String>(json['tasksJson']),
      datesJson: serializer.fromJson<String>(json['datesJson']),
      negotiationsJson: serializer.fromJson<String>(json['negotiationsJson']),
      rawJson: serializer.fromJson<String>(json['rawJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'callId': serializer.toJson<String>(callId),
      'topicsJson': serializer.toJson<String>(topicsJson),
      'tasksJson': serializer.toJson<String>(tasksJson),
      'datesJson': serializer.toJson<String>(datesJson),
      'negotiationsJson': serializer.toJson<String>(negotiationsJson),
      'rawJson': serializer.toJson<String>(rawJson),
    };
  }

  SummariesTableData copyWith({
    String? callId,
    String? topicsJson,
    String? tasksJson,
    String? datesJson,
    String? negotiationsJson,
    String? rawJson,
  }) => SummariesTableData(
    callId: callId ?? this.callId,
    topicsJson: topicsJson ?? this.topicsJson,
    tasksJson: tasksJson ?? this.tasksJson,
    datesJson: datesJson ?? this.datesJson,
    negotiationsJson: negotiationsJson ?? this.negotiationsJson,
    rawJson: rawJson ?? this.rawJson,
  );
  SummariesTableData copyWithCompanion(SummariesTableCompanion data) {
    return SummariesTableData(
      callId: data.callId.present ? data.callId.value : this.callId,
      topicsJson: data.topicsJson.present
          ? data.topicsJson.value
          : this.topicsJson,
      tasksJson: data.tasksJson.present ? data.tasksJson.value : this.tasksJson,
      datesJson: data.datesJson.present ? data.datesJson.value : this.datesJson,
      negotiationsJson: data.negotiationsJson.present
          ? data.negotiationsJson.value
          : this.negotiationsJson,
      rawJson: data.rawJson.present ? data.rawJson.value : this.rawJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SummariesTableData(')
          ..write('callId: $callId, ')
          ..write('topicsJson: $topicsJson, ')
          ..write('tasksJson: $tasksJson, ')
          ..write('datesJson: $datesJson, ')
          ..write('negotiationsJson: $negotiationsJson, ')
          ..write('rawJson: $rawJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    callId,
    topicsJson,
    tasksJson,
    datesJson,
    negotiationsJson,
    rawJson,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SummariesTableData &&
          other.callId == this.callId &&
          other.topicsJson == this.topicsJson &&
          other.tasksJson == this.tasksJson &&
          other.datesJson == this.datesJson &&
          other.negotiationsJson == this.negotiationsJson &&
          other.rawJson == this.rawJson);
}

class SummariesTableCompanion extends UpdateCompanion<SummariesTableData> {
  final Value<String> callId;
  final Value<String> topicsJson;
  final Value<String> tasksJson;
  final Value<String> datesJson;
  final Value<String> negotiationsJson;
  final Value<String> rawJson;
  final Value<int> rowid;
  const SummariesTableCompanion({
    this.callId = const Value.absent(),
    this.topicsJson = const Value.absent(),
    this.tasksJson = const Value.absent(),
    this.datesJson = const Value.absent(),
    this.negotiationsJson = const Value.absent(),
    this.rawJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SummariesTableCompanion.insert({
    required String callId,
    required String topicsJson,
    required String tasksJson,
    required String datesJson,
    required String negotiationsJson,
    required String rawJson,
    this.rowid = const Value.absent(),
  }) : callId = Value(callId),
       topicsJson = Value(topicsJson),
       tasksJson = Value(tasksJson),
       datesJson = Value(datesJson),
       negotiationsJson = Value(negotiationsJson),
       rawJson = Value(rawJson);
  static Insertable<SummariesTableData> custom({
    Expression<String>? callId,
    Expression<String>? topicsJson,
    Expression<String>? tasksJson,
    Expression<String>? datesJson,
    Expression<String>? negotiationsJson,
    Expression<String>? rawJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (callId != null) 'call_id': callId,
      if (topicsJson != null) 'topics_json': topicsJson,
      if (tasksJson != null) 'tasks_json': tasksJson,
      if (datesJson != null) 'dates_json': datesJson,
      if (negotiationsJson != null) 'negotiations_json': negotiationsJson,
      if (rawJson != null) 'raw_json': rawJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SummariesTableCompanion copyWith({
    Value<String>? callId,
    Value<String>? topicsJson,
    Value<String>? tasksJson,
    Value<String>? datesJson,
    Value<String>? negotiationsJson,
    Value<String>? rawJson,
    Value<int>? rowid,
  }) {
    return SummariesTableCompanion(
      callId: callId ?? this.callId,
      topicsJson: topicsJson ?? this.topicsJson,
      tasksJson: tasksJson ?? this.tasksJson,
      datesJson: datesJson ?? this.datesJson,
      negotiationsJson: negotiationsJson ?? this.negotiationsJson,
      rawJson: rawJson ?? this.rawJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (callId.present) {
      map['call_id'] = Variable<String>(callId.value);
    }
    if (topicsJson.present) {
      map['topics_json'] = Variable<String>(topicsJson.value);
    }
    if (tasksJson.present) {
      map['tasks_json'] = Variable<String>(tasksJson.value);
    }
    if (datesJson.present) {
      map['dates_json'] = Variable<String>(datesJson.value);
    }
    if (negotiationsJson.present) {
      map['negotiations_json'] = Variable<String>(negotiationsJson.value);
    }
    if (rawJson.present) {
      map['raw_json'] = Variable<String>(rawJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SummariesTableCompanion(')
          ..write('callId: $callId, ')
          ..write('topicsJson: $topicsJson, ')
          ..write('tasksJson: $tasksJson, ')
          ..write('datesJson: $datesJson, ')
          ..write('negotiationsJson: $negotiationsJson, ')
          ..write('rawJson: $rawJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CallsTableTable callsTable = $CallsTableTable(this);
  late final $TranscriptionSegmentsTableTable transcriptionSegmentsTable =
      $TranscriptionSegmentsTableTable(this);
  late final $SummariesTableTable summariesTable = $SummariesTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    callsTable,
    transcriptionSegmentsTable,
    summariesTable,
  ];
}

typedef $$CallsTableTableCreateCompanionBuilder =
    CallsTableCompanion Function({
      required String id,
      required DateTime startedAt,
      Value<DateTime?> endedAt,
      required int type,
      required String audioPath,
      required int status,
      Value<int> rowid,
    });
typedef $$CallsTableTableUpdateCompanionBuilder =
    CallsTableCompanion Function({
      Value<String> id,
      Value<DateTime> startedAt,
      Value<DateTime?> endedAt,
      Value<int> type,
      Value<String> audioPath,
      Value<int> status,
      Value<int> rowid,
    });

final class $$CallsTableTableReferences
    extends BaseReferences<_$AppDatabase, $CallsTableTable, CallsTableData> {
  $$CallsTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $TranscriptionSegmentsTableTable,
    List<TranscriptionSegmentsTableData>
  >
  _transcriptionSegmentsTableRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.transcriptionSegmentsTable,
        aliasName: $_aliasNameGenerator(
          db.callsTable.id,
          db.transcriptionSegmentsTable.callId,
        ),
      );

  $$TranscriptionSegmentsTableTableProcessedTableManager
  get transcriptionSegmentsTableRefs {
    final manager = $$TranscriptionSegmentsTableTableTableManager(
      $_db,
      $_db.transcriptionSegmentsTable,
    ).filter((f) => f.callId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _transcriptionSegmentsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SummariesTableTable, List<SummariesTableData>>
  _summariesTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.summariesTable,
    aliasName: $_aliasNameGenerator(db.callsTable.id, db.summariesTable.callId),
  );

  $$SummariesTableTableProcessedTableManager get summariesTableRefs {
    final manager = $$SummariesTableTableTableManager(
      $_db,
      $_db.summariesTable,
    ).filter((f) => f.callId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_summariesTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CallsTableTableFilterComposer
    extends Composer<_$AppDatabase, $CallsTableTable> {
  $$CallsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get audioPath => $composableBuilder(
    column: $table.audioPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> transcriptionSegmentsTableRefs(
    Expression<bool> Function($$TranscriptionSegmentsTableTableFilterComposer f)
    f,
  ) {
    final $$TranscriptionSegmentsTableTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.transcriptionSegmentsTable,
          getReferencedColumn: (t) => t.callId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TranscriptionSegmentsTableTableFilterComposer(
                $db: $db,
                $table: $db.transcriptionSegmentsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> summariesTableRefs(
    Expression<bool> Function($$SummariesTableTableFilterComposer f) f,
  ) {
    final $$SummariesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.summariesTable,
      getReferencedColumn: (t) => t.callId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SummariesTableTableFilterComposer(
            $db: $db,
            $table: $db.summariesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CallsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CallsTableTable> {
  $$CallsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get audioPath => $composableBuilder(
    column: $table.audioPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CallsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CallsTableTable> {
  $$CallsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  GeneratedColumn<int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get audioPath =>
      $composableBuilder(column: $table.audioPath, builder: (column) => column);

  GeneratedColumn<int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  Expression<T> transcriptionSegmentsTableRefs<T extends Object>(
    Expression<T> Function(
      $$TranscriptionSegmentsTableTableAnnotationComposer a,
    )
    f,
  ) {
    final $$TranscriptionSegmentsTableTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.transcriptionSegmentsTable,
          getReferencedColumn: (t) => t.callId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TranscriptionSegmentsTableTableAnnotationComposer(
                $db: $db,
                $table: $db.transcriptionSegmentsTable,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> summariesTableRefs<T extends Object>(
    Expression<T> Function($$SummariesTableTableAnnotationComposer a) f,
  ) {
    final $$SummariesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.summariesTable,
      getReferencedColumn: (t) => t.callId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SummariesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.summariesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CallsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CallsTableTable,
          CallsTableData,
          $$CallsTableTableFilterComposer,
          $$CallsTableTableOrderingComposer,
          $$CallsTableTableAnnotationComposer,
          $$CallsTableTableCreateCompanionBuilder,
          $$CallsTableTableUpdateCompanionBuilder,
          (CallsTableData, $$CallsTableTableReferences),
          CallsTableData,
          PrefetchHooks Function({
            bool transcriptionSegmentsTableRefs,
            bool summariesTableRefs,
          })
        > {
  $$CallsTableTableTableManager(_$AppDatabase db, $CallsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CallsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CallsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CallsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> endedAt = const Value.absent(),
                Value<int> type = const Value.absent(),
                Value<String> audioPath = const Value.absent(),
                Value<int> status = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CallsTableCompanion(
                id: id,
                startedAt: startedAt,
                endedAt: endedAt,
                type: type,
                audioPath: audioPath,
                status: status,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime startedAt,
                Value<DateTime?> endedAt = const Value.absent(),
                required int type,
                required String audioPath,
                required int status,
                Value<int> rowid = const Value.absent(),
              }) => CallsTableCompanion.insert(
                id: id,
                startedAt: startedAt,
                endedAt: endedAt,
                type: type,
                audioPath: audioPath,
                status: status,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CallsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                transcriptionSegmentsTableRefs = false,
                summariesTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (transcriptionSegmentsTableRefs)
                      db.transcriptionSegmentsTable,
                    if (summariesTableRefs) db.summariesTable,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (transcriptionSegmentsTableRefs)
                        await $_getPrefetchedData<
                          CallsTableData,
                          $CallsTableTable,
                          TranscriptionSegmentsTableData
                        >(
                          currentTable: table,
                          referencedTable: $$CallsTableTableReferences
                              ._transcriptionSegmentsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CallsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).transcriptionSegmentsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.callId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (summariesTableRefs)
                        await $_getPrefetchedData<
                          CallsTableData,
                          $CallsTableTable,
                          SummariesTableData
                        >(
                          currentTable: table,
                          referencedTable: $$CallsTableTableReferences
                              ._summariesTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CallsTableTableReferences(
                                db,
                                table,
                                p0,
                              ).summariesTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.callId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CallsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CallsTableTable,
      CallsTableData,
      $$CallsTableTableFilterComposer,
      $$CallsTableTableOrderingComposer,
      $$CallsTableTableAnnotationComposer,
      $$CallsTableTableCreateCompanionBuilder,
      $$CallsTableTableUpdateCompanionBuilder,
      (CallsTableData, $$CallsTableTableReferences),
      CallsTableData,
      PrefetchHooks Function({
        bool transcriptionSegmentsTableRefs,
        bool summariesTableRefs,
      })
    >;
typedef $$TranscriptionSegmentsTableTableCreateCompanionBuilder =
    TranscriptionSegmentsTableCompanion Function({
      required String id,
      required String callId,
      required int speaker,
      required String content,
      required int startMs,
      required int endMs,
      Value<int> rowid,
    });
typedef $$TranscriptionSegmentsTableTableUpdateCompanionBuilder =
    TranscriptionSegmentsTableCompanion Function({
      Value<String> id,
      Value<String> callId,
      Value<int> speaker,
      Value<String> content,
      Value<int> startMs,
      Value<int> endMs,
      Value<int> rowid,
    });

final class $$TranscriptionSegmentsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $TranscriptionSegmentsTableTable,
          TranscriptionSegmentsTableData
        > {
  $$TranscriptionSegmentsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CallsTableTable _callIdTable(_$AppDatabase db) =>
      db.callsTable.createAlias(
        $_aliasNameGenerator(
          db.transcriptionSegmentsTable.callId,
          db.callsTable.id,
        ),
      );

  $$CallsTableTableProcessedTableManager get callId {
    final $_column = $_itemColumn<String>('call_id')!;

    final manager = $$CallsTableTableTableManager(
      $_db,
      $_db.callsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_callIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TranscriptionSegmentsTableTableFilterComposer
    extends Composer<_$AppDatabase, $TranscriptionSegmentsTableTable> {
  $$TranscriptionSegmentsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get speaker => $composableBuilder(
    column: $table.speaker,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startMs => $composableBuilder(
    column: $table.startMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get endMs => $composableBuilder(
    column: $table.endMs,
    builder: (column) => ColumnFilters(column),
  );

  $$CallsTableTableFilterComposer get callId {
    final $$CallsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.callId,
      referencedTable: $db.callsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CallsTableTableFilterComposer(
            $db: $db,
            $table: $db.callsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TranscriptionSegmentsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TranscriptionSegmentsTableTable> {
  $$TranscriptionSegmentsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get speaker => $composableBuilder(
    column: $table.speaker,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startMs => $composableBuilder(
    column: $table.startMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get endMs => $composableBuilder(
    column: $table.endMs,
    builder: (column) => ColumnOrderings(column),
  );

  $$CallsTableTableOrderingComposer get callId {
    final $$CallsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.callId,
      referencedTable: $db.callsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CallsTableTableOrderingComposer(
            $db: $db,
            $table: $db.callsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TranscriptionSegmentsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TranscriptionSegmentsTableTable> {
  $$TranscriptionSegmentsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get speaker =>
      $composableBuilder(column: $table.speaker, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<int> get startMs =>
      $composableBuilder(column: $table.startMs, builder: (column) => column);

  GeneratedColumn<int> get endMs =>
      $composableBuilder(column: $table.endMs, builder: (column) => column);

  $$CallsTableTableAnnotationComposer get callId {
    final $$CallsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.callId,
      referencedTable: $db.callsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CallsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.callsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TranscriptionSegmentsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TranscriptionSegmentsTableTable,
          TranscriptionSegmentsTableData,
          $$TranscriptionSegmentsTableTableFilterComposer,
          $$TranscriptionSegmentsTableTableOrderingComposer,
          $$TranscriptionSegmentsTableTableAnnotationComposer,
          $$TranscriptionSegmentsTableTableCreateCompanionBuilder,
          $$TranscriptionSegmentsTableTableUpdateCompanionBuilder,
          (
            TranscriptionSegmentsTableData,
            $$TranscriptionSegmentsTableTableReferences,
          ),
          TranscriptionSegmentsTableData,
          PrefetchHooks Function({bool callId})
        > {
  $$TranscriptionSegmentsTableTableTableManager(
    _$AppDatabase db,
    $TranscriptionSegmentsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TranscriptionSegmentsTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$TranscriptionSegmentsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$TranscriptionSegmentsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> callId = const Value.absent(),
                Value<int> speaker = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<int> startMs = const Value.absent(),
                Value<int> endMs = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TranscriptionSegmentsTableCompanion(
                id: id,
                callId: callId,
                speaker: speaker,
                content: content,
                startMs: startMs,
                endMs: endMs,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String callId,
                required int speaker,
                required String content,
                required int startMs,
                required int endMs,
                Value<int> rowid = const Value.absent(),
              }) => TranscriptionSegmentsTableCompanion.insert(
                id: id,
                callId: callId,
                speaker: speaker,
                content: content,
                startMs: startMs,
                endMs: endMs,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TranscriptionSegmentsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({callId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (callId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.callId,
                                referencedTable:
                                    $$TranscriptionSegmentsTableTableReferences
                                        ._callIdTable(db),
                                referencedColumn:
                                    $$TranscriptionSegmentsTableTableReferences
                                        ._callIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TranscriptionSegmentsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TranscriptionSegmentsTableTable,
      TranscriptionSegmentsTableData,
      $$TranscriptionSegmentsTableTableFilterComposer,
      $$TranscriptionSegmentsTableTableOrderingComposer,
      $$TranscriptionSegmentsTableTableAnnotationComposer,
      $$TranscriptionSegmentsTableTableCreateCompanionBuilder,
      $$TranscriptionSegmentsTableTableUpdateCompanionBuilder,
      (
        TranscriptionSegmentsTableData,
        $$TranscriptionSegmentsTableTableReferences,
      ),
      TranscriptionSegmentsTableData,
      PrefetchHooks Function({bool callId})
    >;
typedef $$SummariesTableTableCreateCompanionBuilder =
    SummariesTableCompanion Function({
      required String callId,
      required String topicsJson,
      required String tasksJson,
      required String datesJson,
      required String negotiationsJson,
      required String rawJson,
      Value<int> rowid,
    });
typedef $$SummariesTableTableUpdateCompanionBuilder =
    SummariesTableCompanion Function({
      Value<String> callId,
      Value<String> topicsJson,
      Value<String> tasksJson,
      Value<String> datesJson,
      Value<String> negotiationsJson,
      Value<String> rawJson,
      Value<int> rowid,
    });

final class $$SummariesTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $SummariesTableTable,
          SummariesTableData
        > {
  $$SummariesTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CallsTableTable _callIdTable(_$AppDatabase db) =>
      db.callsTable.createAlias(
        $_aliasNameGenerator(db.summariesTable.callId, db.callsTable.id),
      );

  $$CallsTableTableProcessedTableManager get callId {
    final $_column = $_itemColumn<String>('call_id')!;

    final manager = $$CallsTableTableTableManager(
      $_db,
      $_db.callsTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_callIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SummariesTableTableFilterComposer
    extends Composer<_$AppDatabase, $SummariesTableTable> {
  $$SummariesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get topicsJson => $composableBuilder(
    column: $table.topicsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tasksJson => $composableBuilder(
    column: $table.tasksJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get datesJson => $composableBuilder(
    column: $table.datesJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get negotiationsJson => $composableBuilder(
    column: $table.negotiationsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rawJson => $composableBuilder(
    column: $table.rawJson,
    builder: (column) => ColumnFilters(column),
  );

  $$CallsTableTableFilterComposer get callId {
    final $$CallsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.callId,
      referencedTable: $db.callsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CallsTableTableFilterComposer(
            $db: $db,
            $table: $db.callsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SummariesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SummariesTableTable> {
  $$SummariesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get topicsJson => $composableBuilder(
    column: $table.topicsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tasksJson => $composableBuilder(
    column: $table.tasksJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get datesJson => $composableBuilder(
    column: $table.datesJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get negotiationsJson => $composableBuilder(
    column: $table.negotiationsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rawJson => $composableBuilder(
    column: $table.rawJson,
    builder: (column) => ColumnOrderings(column),
  );

  $$CallsTableTableOrderingComposer get callId {
    final $$CallsTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.callId,
      referencedTable: $db.callsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CallsTableTableOrderingComposer(
            $db: $db,
            $table: $db.callsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SummariesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SummariesTableTable> {
  $$SummariesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get topicsJson => $composableBuilder(
    column: $table.topicsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tasksJson =>
      $composableBuilder(column: $table.tasksJson, builder: (column) => column);

  GeneratedColumn<String> get datesJson =>
      $composableBuilder(column: $table.datesJson, builder: (column) => column);

  GeneratedColumn<String> get negotiationsJson => $composableBuilder(
    column: $table.negotiationsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get rawJson =>
      $composableBuilder(column: $table.rawJson, builder: (column) => column);

  $$CallsTableTableAnnotationComposer get callId {
    final $$CallsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.callId,
      referencedTable: $db.callsTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CallsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.callsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SummariesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SummariesTableTable,
          SummariesTableData,
          $$SummariesTableTableFilterComposer,
          $$SummariesTableTableOrderingComposer,
          $$SummariesTableTableAnnotationComposer,
          $$SummariesTableTableCreateCompanionBuilder,
          $$SummariesTableTableUpdateCompanionBuilder,
          (SummariesTableData, $$SummariesTableTableReferences),
          SummariesTableData,
          PrefetchHooks Function({bool callId})
        > {
  $$SummariesTableTableTableManager(
    _$AppDatabase db,
    $SummariesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SummariesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SummariesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SummariesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> callId = const Value.absent(),
                Value<String> topicsJson = const Value.absent(),
                Value<String> tasksJson = const Value.absent(),
                Value<String> datesJson = const Value.absent(),
                Value<String> negotiationsJson = const Value.absent(),
                Value<String> rawJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SummariesTableCompanion(
                callId: callId,
                topicsJson: topicsJson,
                tasksJson: tasksJson,
                datesJson: datesJson,
                negotiationsJson: negotiationsJson,
                rawJson: rawJson,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String callId,
                required String topicsJson,
                required String tasksJson,
                required String datesJson,
                required String negotiationsJson,
                required String rawJson,
                Value<int> rowid = const Value.absent(),
              }) => SummariesTableCompanion.insert(
                callId: callId,
                topicsJson: topicsJson,
                tasksJson: tasksJson,
                datesJson: datesJson,
                negotiationsJson: negotiationsJson,
                rawJson: rawJson,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SummariesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({callId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (callId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.callId,
                                referencedTable: $$SummariesTableTableReferences
                                    ._callIdTable(db),
                                referencedColumn:
                                    $$SummariesTableTableReferences
                                        ._callIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SummariesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SummariesTableTable,
      SummariesTableData,
      $$SummariesTableTableFilterComposer,
      $$SummariesTableTableOrderingComposer,
      $$SummariesTableTableAnnotationComposer,
      $$SummariesTableTableCreateCompanionBuilder,
      $$SummariesTableTableUpdateCompanionBuilder,
      (SummariesTableData, $$SummariesTableTableReferences),
      SummariesTableData,
      PrefetchHooks Function({bool callId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CallsTableTableTableManager get callsTable =>
      $$CallsTableTableTableManager(_db, _db.callsTable);
  $$TranscriptionSegmentsTableTableTableManager
  get transcriptionSegmentsTable =>
      $$TranscriptionSegmentsTableTableTableManager(
        _db,
        _db.transcriptionSegmentsTable,
      );
  $$SummariesTableTableTableManager get summariesTable =>
      $$SummariesTableTableTableManager(_db, _db.summariesTable);
}

import 'package:record_summary/domain/enums/call_type.dart';
import 'package:record_summary/domain/enums/recording_status.dart';

class Call {
  final String id;
  final DateTime startedAt;
  final DateTime? endedAt;
  final CallType type;
  final String audioPath;
  final RecordingStatus status;

  const Call({
    required this.id,
    required this.startedAt,
    this.endedAt,
    required this.type,
    required this.audioPath,
    required this.status,
  });

  Duration? get duration =>
      endedAt != null ? endedAt!.difference(startedAt) : null;

  Call copyWith({
    DateTime? endedAt,
    RecordingStatus? status,
  }) =>
      Call(
        id: id,
        startedAt: startedAt,
        endedAt: endedAt ?? this.endedAt,
        type: type,
        audioPath: audioPath,
        status: status ?? this.status,
      );
}
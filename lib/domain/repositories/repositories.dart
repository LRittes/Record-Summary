import 'package:record_summary/domain/entities/call.dart';
import 'package:record_summary/domain/entities/call_summary.dart';
import 'package:record_summary/domain/entities/transcription_segment.dart';

abstract interface class CallRepository {
  Future<void> save(Call call);
  Future<void> update(Call call);
  Future<Call?> findById(String id);
  Future<List<Call>> findAll();
}

abstract interface class TranscriptionRepository {
  Future<void> saveSegments(List<TranscriptionSegment> segments);
  Future<List<TranscriptionSegment>> findByCallId(String callId);
}

abstract interface class SummaryRepository {
  Future<void> save(CallSummary summary);
  Future<CallSummary?> findByCallId(String callId);
}
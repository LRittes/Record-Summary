import 'package:record_summary/domain/entities/call_summary.dart';
import 'package:record_summary/domain/entities/transcription_segment.dart';

abstract interface class SummaryService {
  Future<CallSummary> summarize({
    required String callId,
    required List<TranscriptionSegment> segments,
  });
}
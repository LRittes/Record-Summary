import 'package:record_summary/domain/entities/call.dart';
import 'package:record_summary/domain/enums/recording_status.dart';
import 'package:record_summary/domain/exceptions/summary_exception.dart';
import 'package:record_summary/domain/exceptions/transcription_exception.dart';
import 'package:record_summary/domain/repositories/repositories.dart';
import 'package:record_summary/domain/services/summary_service.dart';
import 'package:record_summary/domain/services/transcription_service.dart';

class CallOrchestrator {
  const CallOrchestrator({
    required CallRepository callRepository,
    required TranscriptionRepository transcriptionRepository,
    required SummaryRepository summaryRepository,
    required TranscriptionService transcriptionService,
    required SummaryService summaryService,
  })  : _callRepository = callRepository,
        _transcriptionRepository = transcriptionRepository,
        _summaryRepository = summaryRepository,
        _transcriptionService = transcriptionService,
        _summaryService = summaryService;

  final CallRepository _callRepository;
  final TranscriptionRepository _transcriptionRepository;
  final SummaryRepository _summaryRepository;
  final TranscriptionService _transcriptionService;
  final SummaryService _summaryService;

  Future<void> process(Call call) async {
    await _callRepository.update(
      call.copyWith(status: RecordingStatus.processing),
    );

    try {
      final segments = await _transcriptionService.transcribe(
        callId: call.id,
        audioPath: call.audioPath,
      );

      await _transcriptionRepository.saveSegments(segments);
      await _callRepository.update(
        call.copyWith(status: RecordingStatus.transcribed),
      );

      final summary = await _summaryService.summarize(
        callId: call.id,
        segments: segments,
      );

      await _summaryRepository.save(summary);
      await _callRepository.update(
        call.copyWith(status: RecordingStatus.summarized),
      );
    } on TranscriptionException {
      await _callRepository.update(
        call.copyWith(status: RecordingStatus.failed),
      );
      rethrow;
    } on SummaryException {
      await _callRepository.update(
        call.copyWith(status: RecordingStatus.failed),
      );
      rethrow;
    }
  }
}
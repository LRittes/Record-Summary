import 'package:record_summary/domain/entities/transcription_segment.dart';

abstract interface class TranscriptionService {
  /// Transcribes [audioPath] stereo file.
  /// Left channel = [Speaker.local], right channel = [Speaker.remote].
  Future<List<TranscriptionSegment>> transcribe({
    required String callId,
    required String audioPath,
  });
}
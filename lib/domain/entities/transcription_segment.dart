enum Speaker { local, remote }

class TranscriptionSegment {
  final String id;
  final String callId;
  final Speaker speaker;
  final String text;
  final Duration startAt;
  final Duration endAt;

  const TranscriptionSegment({
    required this.id,
    required this.callId,
    required this.speaker,
    required this.text,
    required this.startAt,
    required this.endAt,
  });
}
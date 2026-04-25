class CallSummary {
  final String callId;
  final List<String> topics;
  final List<String> tasks;
  final List<DateTime> dates;
  final List<String> negotiations;
  final String rawJson;

  const CallSummary({
    required this.callId,
    required this.topics,
    required this.tasks,
    required this.dates,
    required this.negotiations,
    required this.rawJson,
  });
}
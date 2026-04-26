class SummaryException implements Exception {
  const SummaryException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => 'SummaryException($statusCode): $message';
}
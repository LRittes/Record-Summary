class TranscriptionException implements Exception {
  const TranscriptionException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => 'TranscriptionException($statusCode): $message';
}
class Failure implements Exception {
  final String message;
  final int? code; // http status code
  final Exception? exception;

  Failure({this.code, this.exception, required this.message});

  @override
  String toString() =>
      'Failure(message: $message, code: $code, exception: $exception)';
}

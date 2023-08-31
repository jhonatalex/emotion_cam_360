class ResponseBodyOrError {
  final bool success;
  final String message;
  final int code;

  ResponseBodyOrError(this.success, this.message, this.code);
}

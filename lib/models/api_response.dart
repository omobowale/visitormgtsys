class APIResponse<T> {
  T? data;
  bool? error;
  bool? serverError;
  String? errorMessage;

  APIResponse({
    this.data,
    this.error = false,
    this.serverError = false,
    this.errorMessage,
  });
}

class APIResponse<T> {
  final T? data;
  final bool error;
  final String errorMessage;

  APIResponse({
    required this.data,
    this.errorMessage='',
    this.error = false});
}

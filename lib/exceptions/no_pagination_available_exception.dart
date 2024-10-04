class NoPaginationAvailableException implements Exception {
  final String message;
  NoPaginationAvailableException(this.message);

  @override
  String toString() => 'TokenExpiredException: $message';
}

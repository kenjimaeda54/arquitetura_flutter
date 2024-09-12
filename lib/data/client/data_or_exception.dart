enum Loading { none, loading, success, failure }

class DataOrException<T> {
  final T? data;
  final Loading loading;
  final String? exception;

  DataOrException(
      {required this.data, required this.exception, required this.loading});
}

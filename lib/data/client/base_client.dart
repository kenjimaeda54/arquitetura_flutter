import 'package:dio/dio.dart';

abstract class BaseClient {
  Dio customDio() {
    Dio dio = Dio();
    dio.options = BaseOptions(
        baseUrl: "https://jsonplaceholder.typicode.com",
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10));
    dio.interceptors.add(InterceptorsWrapper(
      onError: (error, handler) {
        print("onError fetch: ${error.message}");
        return handler.next(error);
      },
    ));
    return dio;
  }
}

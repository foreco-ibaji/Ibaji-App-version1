import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'custom_dio_interceptor.dart';

/// <h2> dioService singleton service </h2>
///* DioServices().to()로 사용
class DioServices {
  static final DioServices _dioServices = DioServices._internal();

  //dioService singleton
  factory DioServices() => _dioServices;

  //dio 객체
  static Dio _dio = Dio();

  DioServices._internal() {
    BaseOptions _baseOptions = BaseOptions(
      baseUrl: dotenv.env["apiUrl"]!,
      connectTimeout: const Duration(milliseconds: 10000),
      receiveTimeout: const Duration(milliseconds: 10000),
      sendTimeout: const Duration(milliseconds: 10000),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        // 'X-AUTH-TOKEN': tmpToken
      },
    );
    _dio = Dio(_baseOptions);
    _dio.interceptors.add(CustomDioInterceptor());
  }

  Dio to() {
    return _dio;
  }

  ///* interceptor 내부의 토큰을 지정해주는 메소드
  void setToken(String token) {
    _dio.options.headers = {'X-AUTH-TOKEN': token};
  }

  ///* interceptor 내부의 토큰을 reset 해주는 메소드
  void removeToken() {
    _dio.options.headers['X-AUTH-TOKEN'].clear();
  }
}

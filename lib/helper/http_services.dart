import 'package:innersight/app/constant.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class HttpServices {
  static final HttpServices _instance = HttpServices._internal();
  factory HttpServices() => _instance;
  HttpServices._internal();

  Dio? _dio;

  final Duration _timeout = const Duration(seconds: 6);

  final Map<String, dynamic> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'language': 'en'
  };

  Dio getDioInstance() {
    _dio ??= Dio(
      BaseOptions(
        baseUrl: Constant.chatUrl,
        connectTimeout: _timeout,
        receiveTimeout: _timeout,
        headers: _headers,
      ),
    );
    _dio!.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      // responseHeader: true,
    ));
    return _dio!;
  }
}

import 'dart:io';

import 'package:dio/dio.dart';

import 'package:logger/logger.dart';

import 'dio_connectivity_request_retrier.dart';

class AppInterceptors extends Interceptor {
  final DioConnectivityRequestRetry requestRetry;
  final Logger _logger = Logger();

  AppInterceptors({required this.requestRetry});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers["Content-Type"] = 'application/json';
    _logger.i('REQUEST[${options.method}] => PATH: ${options.path}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.i(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    _logger.e(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    if (_shouldRetry(err)) {
      try {
        await requestRetry.scheduleRequestRetry(err.requestOptions, handler);

        return;
      } catch (e) {
        super.onError(err, handler);
      }
    }

    super.onError(err, handler);
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionError &&
        err.error != null &&
        err.error is SocketException;
  }
}

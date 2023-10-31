import 'dart:async';

import 'package:dio/dio.dart';

import '../network/netwok_info.dart';

class DioConnectivityRequestRetry {
  final Dio dio;
  final NetworkInfo networkInfo;

  DioConnectivityRequestRetry({
    required this.dio,
    required this.networkInfo,
  });

  Future<void> scheduleRequestRetry(
      RequestOptions requestOptions, ErrorInterceptorHandler handler) async {
    networkInfo.listenInternetConnection(() async {
      await networkInfo.cancel();
      await dio
          .fetch<void>(requestOptions)
          .then((value) => handler.resolve(value));
    });
  }
}

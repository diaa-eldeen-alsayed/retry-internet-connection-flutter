import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;

  Future<void> listenInternetConnection(Function disconnectCallBack,
      {Function? connectCallBack});

  Future<void> cancel();
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectionChecker;
  StreamSubscription? _streamSubscription;

  NetworkInfoImpl({required this.connectionChecker});

  @override
  Future<bool> get isConnected async =>
      await connectionChecker.checkConnectivity() != ConnectivityResult.none;

  @override
  Future<void> listenInternetConnection(Function disconnectCallBack,
      {Function? connectCallBack}) async {
    _streamSubscription = connectionChecker.onConnectivityChanged
        .listen((connectivityResult) async {
      if (connectivityResult != ConnectivityResult.none) {
        await disconnectCallBack();
      }
    });
  }

  @override
  Future<void> cancel() async {
    await _streamSubscription?.cancel();
  }
}

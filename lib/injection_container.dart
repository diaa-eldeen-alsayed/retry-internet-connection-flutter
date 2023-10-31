



import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:internet_connection_retry/core/api/app_interceptors.dart';
import 'package:internet_connection_retry/core/api/dio_connectivity_request_retrier.dart';
import 'package:internet_connection_retry/core/network/netwok_info.dart';



GetIt getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  // core

  getIt.registerLazySingleton<NetworkInfo>(
          () => NetworkInfoImpl(connectionChecker: getIt()));

  // Blocs

  
  // Use cases

 
  // Repository
  

  // Data Sources

  



  //! External

  
  getIt.registerLazySingleton(() => Connectivity());

  // Dio
  setupDio();
}

setupDio() {


  LogInterceptor logInterceptor = LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: false,
      error: true);
  Dio dio = Dio();
  getIt.registerLazySingleton(() => DioConnectivityRequestRetry(dio: dio, networkInfo: getIt()));
  
  AppInterceptors appInterceptors = AppInterceptors( requestRetry: getIt(),);
  dio.interceptors.add(appInterceptors);
  dio.interceptors.add(logInterceptor);

  
  getIt.registerSingleton<Dio>(dio);

}

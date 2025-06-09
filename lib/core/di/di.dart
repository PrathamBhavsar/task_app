import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../data/api/api_constants.dart';
import '../../data/api/api_handler.dart';
import '../../data/api/api_service.dart';
import '../services/log_service.dart';

final getIt = GetIt.instance;

void setupLocator() {
  setupApiModule();
  setupHelpers();
}

void setupApiModule() {
  getIt.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        baseUrl: ApiConstants.currentBaseUrl,
      ),
    ),
  );

  getIt.registerLazySingleton<ApiService>(() => ApiService(getIt<Dio>()));

  getIt.registerLazySingleton<ApiHandler>(
    () => ApiHandler(getIt<LogService>()),
  );
}

void setupHelpers() {
  getIt.registerLazySingleton<LogService>(LogService.new);
}

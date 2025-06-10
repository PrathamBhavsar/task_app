import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../../data/api/api_constants.dart';
import '../../data/api/api_handler.dart';
import '../../data/api/api_helper.dart';
import '../../data/api/api_service.dart';
import '../../data/repositories/client_repository.dart';
import '../../data/repositories/task_repository.dart';
import '../../data/repositories/user_repository.dart';
import '../../presentation/providers/appointment_provider.dart';
import '../../presentation/providers/auth_provider.dart';
import '../../presentation/providers/client_provider.dart';
import '../../presentation/providers/home_provider.dart';
import '../../presentation/providers/measurement_provider.dart';
import '../../presentation/providers/task_provider.dart';
import '../../presentation/providers/user_provider.dart';
import '../services/log_service.dart';

final getIt = GetIt.instance;

void setupLocator() {
  setupApiModule();
  setupHelpers();
  setupRepositories();
  setupProviders();
}

void setupApiModule() {
  getIt.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
        baseUrl: ApiConstants.currentBaseUrl,
      ),
    )..interceptors.add(getIt<AwesomeDioInterceptor>()),
  );

  getIt.registerLazySingleton<ApiService>(() => ApiService(getIt<Dio>()));

  getIt.registerLazySingleton<ApiHandler>(
    () => ApiHandler(getIt<LogService>()),
  );

  getIt.registerLazySingleton<ApiHelper>(
    () => ApiHelper(
      service: getIt<ApiService>(),
      handler: getIt<ApiHandler>(),
      logger: getIt<LogService>(),
    ),
  );
}

void setupRepositories() {
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepository(getIt<ApiHelper>()),
  );

  getIt.registerLazySingleton<TaskRepository>(
    () => TaskRepository(getIt<ApiHelper>()),
  );

  getIt.registerLazySingleton<ClientRepository>(
    () => ClientRepository(getIt<ApiHelper>()),
  );
}

void setupHelpers() {
  getIt.registerLazySingleton<LogService>(LogService.new);

  getIt.registerLazySingleton<AwesomeDioInterceptor>(
    () => AwesomeDioInterceptor(
      logRequestHeaders: true,
      logRequestTimeout: false,
      logResponseHeaders: false,
      logger: debugPrint,
    ),
  );
}

void setupProviders() {
  getIt.registerLazySingleton<AuthProvider>(AuthProvider.new);

  getIt.registerLazySingleton<UserProvider>(
    () => UserProvider(getIt<UserRepository>()),
  );

  getIt.registerLazySingleton<ClientProvider>(
        () => ClientProvider(getIt<ClientRepository>()),
  );

  getIt.registerLazySingleton<HomeProvider>(HomeProvider.new);

  getIt.registerLazySingleton<TaskProvider>(
    () => TaskProvider(getIt<TaskRepository>()),
  );

  getIt.registerLazySingleton<AppointmentProvider>(AppointmentProvider.new);

  getIt.registerLazySingleton<MeasurementProvider>(MeasurementProvider.new);
}

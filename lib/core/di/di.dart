import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../data/api/api_constants.dart';
import '../../data/api/api_handler.dart';
import '../../data/api/api_helper.dart';
import '../../data/api/api_service.dart';
import '../../data/repositories/client_repository.dart';
import '../../data/repositories/task_repository.dart';
import '../../data/repositories/user_repository.dart';
import '../../domain/repositories/client_repo.dart';
import '../../domain/usecases/client_usecase.dart';
import '../../presentation/blocs/auth/auth_bloc.dart';
import '../../presentation/blocs/client/client_bloc.dart';
import '../../presentation/blocs/home/home_bloc.dart';
import '../../presentation/providers/appointment_provider.dart';
import '../../presentation/providers/measurement_provider.dart';
import '../../presentation/providers/task_provider.dart';
import '../../presentation/providers/user_provider.dart';
import '../helpers/cache_helper.dart';
import '../helpers/shared_prefs_helper.dart';
import '../helpers/snack_bar_helper.dart';
import '../helpers/log_helper.dart';

final getIt = GetIt.instance;
final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

void setupLocator() {
  setupApiModule();
  setupHelpers();
  setupRepositories();
  setupUseCases();
  setupBlocs();
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

  getIt.registerLazySingleton<ApiHandler>(() => ApiHandler(getIt<LogHelper>()));

  getIt.registerLazySingleton<ApiHelper>(
    () => ApiHelper(
      service: getIt<ApiService>(),
      handler: getIt<ApiHandler>(),
      logger: getIt<LogHelper>(),
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

  // Data layer
  getIt.registerLazySingleton<ClientRepository>(
    () => ClientRepositoryImpl(getIt<ApiHelper>()),
  );
}

void setupUseCases() {
  getIt.registerLazySingleton(
    () => GetAllClientsUseCase(getIt<ClientRepository>()),
  );
}

void setupHelpers() {
  getIt.registerLazySingleton<LogHelper>(LogHelper.new);

  getIt.registerLazySingleton<AwesomeDioInterceptor>(
    () => AwesomeDioInterceptor(
      logRequestHeaders: true,
      logRequestTimeout: false,
      logResponseHeaders: false,
      logger: debugPrint,
    ),
  );

  getIt.registerLazySingleton<SnackBarHelper>(
    () => SnackBarHelper(scaffoldMessengerKey),
  );

  getIt.registerLazySingleton<SharedPrefHelper>(SharedPrefHelper.new);

  getIt.registerLazySingleton<CacheHelper>(
    () => CacheHelper(getIt<SharedPrefHelper>()),
  );
}

void setupBlocs() {
  getIt.registerFactory(() => ClientBloc(getIt<GetAllClientsUseCase>()));

  getIt.registerFactory(() => HomeBloc(getIt<CacheHelper>()));

  getIt.registerFactory(AuthBloc.new);
}

void setupProviders() {

  getIt.registerLazySingleton<UserProvider>(
    () => UserProvider(getIt<UserRepository>()),
  );

  getIt.registerLazySingleton<TaskProvider>(
    () => TaskProvider(getIt<TaskRepository>()),
  );

  getIt.registerLazySingleton<AppointmentProvider>(AppointmentProvider.new);

  getIt.registerLazySingleton<MeasurementProvider>(MeasurementProvider.new);
}

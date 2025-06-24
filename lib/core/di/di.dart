import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../data/api/api_constants.dart';
import '../../data/api/api_handler.dart';
import '../../data/api/api_helper.dart';
import '../../data/api/api_service.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/bill_repository_impl.dart';
import '../../data/repositories/client_repository_impl.dart';
import '../../data/repositories/designer_repository_impl.dart';
import '../../data/repositories/message_repository_impl.dart';
import '../../data/repositories/task_repository_impl.dart';
import '../../data/repositories/timeline_repository_impl.dart';
import '../../data/repositories/user_repository.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/bill_repository.dart';
import '../../domain/repositories/client_repository.dart';
import '../../domain/repositories/designer_repository.dart';
import '../../domain/repositories/message_repository.dart';
import '../../domain/repositories/task_repository.dart';
import '../../domain/repositories/timeline_repository.dart';
import '../../domain/usecases/auth_usecase.dart';
import '../../domain/usecases/bill_usecase.dart';
import '../../domain/usecases/client_usecase.dart';
import '../../domain/usecases/designer_usecase.dart';
import '../../domain/usecases/message_usecase.dart';
import '../../domain/usecases/put_message_usecase.dart';
import '../../domain/usecases/put_task_usecase.dart';
import '../../domain/usecases/task_usecase.dart';
import '../../domain/usecases/timeline_usecase.dart';
import '../../domain/usecases/user_usecase.dart';
import '../../presentation/blocs/auth/auth_bloc.dart';
import '../../presentation/blocs/bill/bill_bloc.dart';
import '../../presentation/blocs/client/client_bloc.dart';
import '../../presentation/blocs/designer/designer_bloc.dart';
import '../../presentation/blocs/home/home_bloc.dart';
import '../../presentation/blocs/message/message_bloc.dart';
import '../../presentation/blocs/tab/tab_bloc.dart';
import '../../presentation/blocs/task/task_bloc.dart';
import '../../presentation/blocs/task_form/task_form_bloc.dart';
import '../../presentation/blocs/timeline/timeline_bloc.dart';
import '../../presentation/blocs/user/user_bloc.dart';
import '../helpers/cache_helper.dart';
import '../helpers/shared_prefs_helper.dart';
import '../helpers/snack_bar_helper.dart';
import '../helpers/log_helper.dart';

final getIt = GetIt.instance;
final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

void setupLocator() {
  setupApiModule();
  setupHelpers();

  setupHome();
  setupTaskForm();
  setupAuth();
  setupTask();
  setupClient();
  setupDesigner();
  setupBill();
  setupMessage();
  setupTimeline();
  setupUser();
  getIt.registerFactory(TabBloc.new);
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
    () => ApiHandler(
      getIt<LogHelper>(),
      onError: (error) => getIt<SnackBarHelper>().showError(error.message),
    ),
  );

  getIt.registerLazySingleton<ApiHelper>(
    () => ApiHelper(
      service: getIt<ApiService>(),
      handler: getIt<ApiHandler>(),
      logger: getIt<LogHelper>(),
    ),
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

void setupHome() {
  getIt.registerFactory(() => HomeBloc(getIt<CacheHelper>()));
}

void setupTaskForm() {
  getIt.registerFactory(
    () => TaskFormBloc(
      getAllCustomers: getIt<GetAllClientsUseCase>(),
      getAllAgencies: getIt<GetAllUsersUseCase>(),
    ),
  );
}

void setupAuth() {
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<ApiHelper>()),
  );

  getIt.registerLazySingleton(() => AuthUseCase(getIt<AuthRepository>()));

  getIt.registerFactory(
    () => AuthBloc(getIt<CacheHelper>(), getIt<AuthUseCase>()),
  );
}

void setupTask() {
  getIt.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(getIt<ApiHelper>()),
  );

  getIt.registerLazySingleton(
    () => GetAllTasksUseCase(getIt<TaskRepository>()),
  );

  getIt.registerLazySingleton(() => PutTaskUseCase(getIt<TaskRepository>()));

  getIt.registerFactory(
    () => TaskBloc(getIt<GetAllTasksUseCase>(), getIt<PutTaskUseCase>()),
  );
}

void setupClient() {
  getIt.registerLazySingleton<ClientRepository>(
    () => ClientRepositoryImpl(getIt<ApiHelper>()),
  );

  getIt.registerLazySingleton(
    () => GetAllClientsUseCase(getIt<ClientRepository>()),
  );

  getIt.registerFactory(() => ClientBloc(getIt<GetAllClientsUseCase>()));
}

void setupDesigner() {
  getIt.registerLazySingleton<DesignerRepository>(
    () => DesignerRepositoryImpl(getIt<ApiHelper>()),
  );

  getIt.registerLazySingleton(
    () => GetAllDesignersUseCase(getIt<DesignerRepository>()),
  );

  getIt.registerFactory(() => DesignerBloc(getIt<GetAllDesignersUseCase>()));
}

void setupBill() {
  getIt.registerLazySingleton<BillRepository>(
    () => BillRepositoryImpl(getIt<ApiHelper>()),
  );

  getIt.registerLazySingleton(
    () => GetAllBillsUseCase(getIt<BillRepository>()),
  );

  getIt.registerFactory(() => BillBloc(getIt<GetAllBillsUseCase>()));
}

void setupMessage() {
  getIt.registerLazySingleton<MessageRepository>(
    () => MessageRepositoryImpl(getIt<ApiHelper>()),
  );

  getIt.registerLazySingleton(
    () => GetAllMessagesUseCase(getIt<MessageRepository>()),
  );

  getIt.registerLazySingleton(
    () => PutMessageUseCase(getIt<MessageRepository>()),
  );

  getIt.registerFactory(
    () =>
        MessageBloc(getIt<GetAllMessagesUseCase>(), getIt<PutMessageUseCase>()),
  );
}

void setupTimeline() {
  getIt.registerLazySingleton<TimelineRepository>(
    () => TimelineRepositoryImpl(getIt<ApiHelper>()),
  );

  getIt.registerLazySingleton(
    () => GetAllTimelinesUseCase(getIt<TimelineRepository>()),
  );

  getIt.registerFactory(() => TimelineBloc(getIt<GetAllTimelinesUseCase>()));
}

void setupUser() {
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepository(getIt<ApiHelper>()),
  );

  getIt.registerLazySingleton(
    () => GetAllUsersUseCase(getIt<UserRepository>()),
  );

  getIt.registerFactory(() => UserBloc(getIt<GetAllUsersUseCase>()));
}

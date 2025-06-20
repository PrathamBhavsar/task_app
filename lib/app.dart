import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/di/di.dart';
import 'core/router/app_router.dart';
import 'presentation/blocs/auth/auth_bloc.dart';
import 'presentation/blocs/bill/bill_bloc.dart';
import 'presentation/blocs/client/client_bloc.dart';
import 'presentation/blocs/home/home_bloc.dart';
import 'presentation/blocs/tab/tab_bloc.dart';
import 'presentation/blocs/task/task_bloc.dart';
import 'utils/constants/app_constants.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<ClientBloc>()),
          BlocProvider(create: (_) => getIt<HomeBloc>()),
          BlocProvider(create: (_) => getIt<AuthBloc>()),
          BlocProvider(create: (_) => getIt<BillBloc>()),
          BlocProvider(create: (_) => getIt<TabBloc>()),
          BlocProvider(create: (_) => getIt<TaskBloc>()),

          // ChangeNotifierProvider(create: (_) => getIt<AuthProvider>()),
          // ChangeNotifierProvider(create: (_) => getIt<UserProvider>()),
          // ChangeNotifierProvider(create: (_) => getIt<ClientProvider>()),
          // ChangeNotifierProvider(create: (_) => getIt<HomeProvider>()),
          // ChangeNotifierProvider(create: (_) => getIt<TaskProvider>()),
          // ChangeNotifierProvider(create: (_) => getIt<AppointmentProvider>()),
          // ChangeNotifierProvider(create: (_) => getIt<MeasurementProvider>()),
        ],
        child: MaterialApp.router(
          scaffoldMessengerKey: scaffoldMessengerKey,
          routerConfig: AppRouter.router,
          theme: AppThemes.themeData,
        ),
      ),
    );
  }
}

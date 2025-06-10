import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'core/di/di.dart';
import 'core/router/app_router.dart';
import 'presentation/providers/appointment_provider.dart';
import 'presentation/providers/auth_provider.dart';
import 'presentation/providers/home_provider.dart';
import 'presentation/providers/measurement_provider.dart';
import 'presentation/providers/task_provider.dart';
import 'presentation/providers/user_provider.dart';
import 'utils/constants/app_constants.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => getIt<AuthProvider>()),
          ChangeNotifierProvider(create: (_) => getIt<UserProvider>()),
          ChangeNotifierProvider(create: (_) => getIt<HomeProvider>()),
          ChangeNotifierProvider(create: (_) => getIt<TaskProvider>()),
          ChangeNotifierProvider(create: (_) => getIt<AppointmentProvider>()),
          ChangeNotifierProvider(create: (_) => getIt<MeasurementProvider>()),
        ],
        child: MaterialApp.router(
          routerConfig: AppRouter.router,
          theme: AppThemes.themeData,
        ),
      ),
    );
  }
}

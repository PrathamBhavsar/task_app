import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'core/router/app_router.dart';
import 'presentation/providers/appointment_provider.dart';
import 'presentation/providers/auth_provider.dart';
import 'presentation/providers/home_provider.dart';
import 'presentation/providers/measurement_provider.dart';
import 'presentation/providers/task_provider.dart';
import 'utils/constants/app_constants.dart';
// import 'utils/constants/secrets/secrets.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  // await Supabase.initialize(
  //   url: AppSecrets.apiUrl,
  //   anonKey: AppSecrets.serviceKey,
  // );
  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => HomeProvider()),
          ChangeNotifierProvider(create: (_) => TaskProvider()),
          ChangeNotifierProvider(create: (_) => AppointmentProvider()),
          ChangeNotifierProvider(create: (_) => MeasurementProvider()),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    routerConfig: AppRouter.router(),
    theme: ThemeData(
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.black,
        selectionColor: AppColors.accent,
        selectionHandleColor: Colors.black,
      ),
      iconTheme: IconThemeData(color: AppColors.accent),
      fontFamily: 'Inter',
      splashColor: Colors.black.withAlpha(2),
      inputDecorationTheme: InputDecorationTheme(focusColor: Colors.black),
      appBarTheme: AppBarTheme(backgroundColor: Colors.white),
      scaffoldBackgroundColor: Colors.white,
      dividerTheme: DividerThemeData(color: Colors.transparent),
    ),
  );
}

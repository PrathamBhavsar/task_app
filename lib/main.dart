import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'core/router/app_router.dart';
import 'presentation/providers/appointment_provider.dart';
import 'presentation/providers/auth_provider.dart';
import 'presentation/providers/home_provider.dart';
import 'presentation/providers/measurement_provider.dart';
import 'presentation/providers/task_provider.dart';
// import 'utils/constants/secrets/secrets.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  // await Supabase.initialize(
  //   url: AppSecrets.apiUrl,
  //   anonKey: AppSecrets.serviceKey,
  // );
  AppRouter.init(true);
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

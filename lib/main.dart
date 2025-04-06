import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/router/app_router.dart';
import 'presentation/providers/appointment_provider.dart';
import 'presentation/providers/auth_provider.dart';
import 'presentation/providers/home_provider.dart';
import 'presentation/providers/transaction_provider.dart';
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
          ChangeNotifierProvider(create: (_) => TransactionProvider()),
          ChangeNotifierProvider(create: (_) => AppointmentProvider()),
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
      fontFamily: 'Inter',
      splashColor: Colors.black.withAlpha(2),
      inputDecorationTheme: InputDecorationTheme(focusColor: Colors.black),
      appBarTheme: AppBarTheme(backgroundColor: Colors.white),
      scaffoldBackgroundColor: Colors.white,
      dividerTheme: DividerThemeData(color: Colors.transparent),
    ),
  );
}

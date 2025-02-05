import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'constants/app_consts.dart';
import 'providers/auth_provider.dart';
import 'providers/measurement_provider.dart';
import 'providers/quotation_provider.dart';
import 'providers/task_provider.dart';
import 'router/app_router.dart';
import 'secrets/app_secrets.dart';
import 'services/shared_pref_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseSecureKey,
  );
  await SharedPrefService().init();
  var prefs = SharedPrefService();
  bool isLoggedIn = prefs.isLoggedIn();

  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthProvider>(
            create: (_) => AuthProvider.instance,
          ),
          ChangeNotifierProvider<TaskProvider>(
            create: (_) => TaskProvider.instance,
          ),
          ChangeNotifierProvider<MeasurementProvider>(
            create: (_) => MeasurementProvider.instance,
          ),
          ChangeNotifierProvider<QuotationProvider>(
            create: (_) => QuotationProvider.instance,
          ),
        ],
        child: MyApp(isLoggedIn: isLoggedIn),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        theme: ThemeData(
          fontFamily: 'Poppins',
          primaryTextTheme: TextTheme(),
          primaryColor: AppColors.primary,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: AppColors.primarySwatch,
            accentColor: AppColors.textFieldBg,
          ).copyWith(
            secondary: AppColors.green,
          ),
        ),
        routerConfig: MyRouter.router(isLoggedIn),
      );
}

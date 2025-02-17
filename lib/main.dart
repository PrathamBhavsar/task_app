import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/constants/app_consts.dart';
import 'data/repositories/priority_repository.dart';
import 'data/repositories/status_repository.dart';
import 'domain/use_cases/priority_use_cases.dart';
import 'domain/use_cases/status_use_cases.dart';
import 'old/router/app_router.dart';
import 'old/secrets/secrets.dart';
import 'old/services/shared_pref_service.dart';
import 'presentation/providers/priority_provider.dart';
import 'presentation/providers/status_provider.dart';

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
          ChangeNotifierProvider(
            create: (_) => PriorityProvider(
              GetPrioritiesUseCase(
                PriorityRepository(),
              ),
            ),
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

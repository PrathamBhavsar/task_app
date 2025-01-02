import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task_app/constants/app_colors.dart';
import 'package:task_app/providers/auth_provider.dart';
import 'package:task_app/providers/task_provider.dart';
import 'package:task_app/router/app_router.dart';
import 'package:task_app/secrets/app_secrets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseSecureKey,
  );

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider.instance,
        ),
        ChangeNotifierProvider<TaskProvider>(
          create: (_) => TaskProvider.instance,
        ),
      ],
      child: MyApp(isLoggedIn: isLoggedIn),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        fontFamily: 'Poppins',
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
}

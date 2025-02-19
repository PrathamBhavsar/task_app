import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/router/router.dart';
import 'data/repositories/client_repository.dart';
import 'data/repositories/designer_repository.dart';
import 'data/repositories/priority_repository.dart';
import 'data/repositories/status_repository.dart';
import 'data/repositories/task_repository.dart';
import 'domain/use_cases/client_use_cases.dart';
import 'domain/use_cases/designer_use_cases.dart';
import 'domain/use_cases/priority_use_cases.dart';
import 'domain/use_cases/status_use_cases.dart';
import 'domain/use_cases/task_use_cases.dart';
import 'presentation/providers/auth_provider.dart';
import 'presentation/providers/home_provider.dart';
import 'presentation/providers/task_provider.dart';
import 'utils/constants/app_consts.dart';
import 'utils/constants/secrets/secrets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseSecureKey,
  );
  bool isLoggedIn = true;

  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => HomeProvider(
              getStatusesUseCase: GetStatusesUseCase(
                StatusRepository(),
              ),
              getPrioritiesUseCase: GetPrioritiesUseCase(
                PriorityRepository(),
              ),
              getDesignersUseCase: GetDesignersUseCase(
                DesignerRepository(),
              ),
              getClientsUseCase: GetClientsUseCase(
                ClientRepository(),
              ),
            ),
          ),
          ChangeNotifierProvider(create: (_) => AuthProvider.instance),
          ChangeNotifierProvider(
            create: (_) => TaskProvider(
              GetTasksUseCase(
                TaskRepository(),
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

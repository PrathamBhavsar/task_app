import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/di.dart';
import '../../../utils/constants/app_constants.dart';
import '../../providers/task_provider.dart';
import '../../providers/user_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      final userProvider = getIt<UserProvider>();
      final taskProvider = getIt<TaskProvider>();

      // Fetch the rest in parallel
      final futures = [
        // userProvider.fetchAllUsers(),
        taskProvider.fetchAllTasks(),
      ];

      await Future.wait(futures);

      if (!mounted) {
        return;
      }

      context.go(AppRoutes.home);
    } catch (e) {
      debugPrint("Initialization failed: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

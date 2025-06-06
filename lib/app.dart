import 'package:flutter/material.dart';

import 'core/router/app_router.dart';
import 'utils/constants/app_constants.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router,
      theme: AppThemes.themeData,
    );
  }
}

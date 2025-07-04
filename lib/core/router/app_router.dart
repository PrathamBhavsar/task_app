import 'package:go_router/go_router.dart';

import '../../utils/constants/app_constants.dart';
import 'routes.dart';

class AppRouter {
  static late final GoRouter _router;

  static void init(bool isLoggedIn) {
    _router = GoRouter(
      debugLogDiagnostics: true,
      requestFocus: true,
      initialLocation: isLoggedIn ? AppRoutes.taskDetails : AppRoutes.auth,
      routes: appRoutes,
    );
  }

  static GoRouter get router => _router;
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/agency.dart';
import '../../data/models/task.dart';
import '../../presentation/screens/agency/agency_detail_page.dart';
import '../../presentation/screens/auth/auth_screen.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/task/task_detail_page.dart';

abstract class AppRouter {
  static GoRouter router() => GoRouter(
    initialLocation: '/taskDetails',
    routes: [
      GoRoute(
        path: '/auth',
        name: 'auth',
        pageBuilder: (context, state) => _slideTransition(AuthScreen(), state),
      ),

      GoRoute(
        path: '/home',
        name: 'home',
        pageBuilder: (context, state) => _slideTransition(HomeScreen(), state),
      ),
      GoRoute(
        path: '/agencyDetails',
        name: 'agencyDetails',
        pageBuilder: (context, state) {
          final agency = state.extra as Agency;
          return _slideTransition(AgencyDetailPage(agency: agency), state);
        },
      ),
      GoRoute(
        path: '/taskDetails',
        name: 'taskDetails',
        pageBuilder: (context, state) {
          // final task = state.extra as Task;
          final task = Task.sampleTasks.first;
          return _slideTransition(TaskDetailPage(task: task), state);
        },
      ),
    ],
  );
}

Page<dynamic> _slideTransition(Widget screen, GoRouterState state) =>
    CustomTransitionPage(
      key: state.pageKey,
      child: screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    );

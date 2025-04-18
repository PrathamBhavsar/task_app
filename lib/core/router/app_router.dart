import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/agency.dart';
import '../../data/models/task.dart';
import '../../presentation/screens/agency/agency_detail_page.dart';
import '../../presentation/screens/auth/auth_screen.dart';
import '../../presentation/screens/bill/review_bill_screen.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/measurement/measurement_screen.dart';
import '../../presentation/screens/task/edit_task_page.dart';
import '../../presentation/screens/task/task_detail_page.dart';

abstract class AppRouter {
  static GoRouter router() => GoRouter(
    initialLocation: '/reviewBill',
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
          final Task? task = state.extra as Task?;
          return _slideTransition(
            TaskDetailPage(task: task ?? Task.empty()),
            state,
          );
        },
      ),
      GoRoute(
        path: '/editTask',
        name: 'editTask',
        pageBuilder: (context, state) {
          final data = state.extra as Map<String, dynamic>;
          return _slideTransition(
            EditTaskPage(task: data['task'], isNew: data['isNew']),
            state,
          );
        },
      ),
      GoRoute(
        path: '/measurement',
        name: 'measurement',
        pageBuilder:
            (context, state) => _slideTransition(MeasurementScreen(), state),
      ),
      GoRoute(
        path: '/reviewBill',
        name: 'reviewBill',
        pageBuilder:
            (context, state) => _slideTransition(ReviewBillScreen(), state),
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

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_app/views/auth/login_screen.dart';
import 'package:task_app/views/auth/signup_screen.dart';
import 'package:task_app/views/home/home_screen.dart';
import 'package:task_app/views/home/pages/notification/notification_screen.dart';
import 'package:task_app/views/home/pages/task%20list/task_list_page.dart';
import 'package:task_app/views/task/task_detail_screen.dart';
import 'package:task_app/views/task/widgets/measurement/measurement_screen.dart';
import 'package:task_app/views/task/widgets/quotation/quotation_screen.dart';

abstract class MyRouter {
  static GoRouter router(bool isLoggedIn) {
    return GoRouter(
        initialLocation: isLoggedIn
            ? '/taskDetails?isSalesperson=false&isNewTask=false&dealNo=25-0019'
            // ? '/measurement'
            : '/signup',
        routes: [
          GoRoute(
            path: '/home',
            name: 'home',
            builder: (BuildContext context, GoRouterState state) =>
                const HomeScreen(),
          ),
          GoRoute(
            path: '/login',
            name: 'login',
            builder: (BuildContext context, GoRouterState state) =>
                const LoginScreen(),
          ),
          GoRoute(
            path: '/signup',
            name: 'signup',
            builder: (BuildContext context, GoRouterState state) =>
                const SignupScreen(),
          ),
          GoRoute(
            path: '/taskDetails',
            name: 'taskDetails',
            builder: (BuildContext context, GoRouterState state) {
              final isSalesperson =
                  state.uri.queryParameters['isSalesperson'] == 'true';
              final isNewTask =
                  state.uri.queryParameters['isNewTask'] == 'true';
              final dealNo = state.uri.queryParameters['dealNo'] ?? '';

              return TaskDetailScreen(
                isNewTask: isNewTask,
                dealNo: dealNo,
                isSalesperson: isSalesperson,
              );
            },
          ),
          GoRoute(
            path: '/taskList',
            name: 'taskList',
            builder: (BuildContext context, GoRouterState state) =>
                const TaskListPage(),
          ),
          GoRoute(
            path: '/notifications',
            name: 'notifications',
            builder: (BuildContext context, GoRouterState state) =>
                const NotificationScreen(),
          ),
          GoRoute(
            path: '/measurement',
            name: 'measurement',
            builder: (BuildContext context, GoRouterState state) =>
                const MeasurementScreen(),
          ),
          GoRoute(
            path: '/quotation',
            name: 'quotation',
            builder: (BuildContext context, GoRouterState state) =>
                const QuotationScreen(),
          ),
        ]);
  }
}

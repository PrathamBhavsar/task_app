import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/screens/splash/splash_screen.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/task/detail.dart';

abstract class MyRouter {
  static GoRouter router(bool isLoggedIn) => GoRouter(
        initialLocation: true
            // ? '/taskDetails?isSalesperson=false&isNewTask=false&dealNo=25-0019'
            ? '/splash'
            : '/signup',
        // : '/taskDetails?isSalesperson=false&isNewTask=false&dealNo=25-0019',
        routes: [
          GoRoute(
            path: '/splash',
            name: 'splash',
            builder: (BuildContext context, GoRouterState state) =>
                const SplashScreen(),
          ),
          GoRoute(
            path: '/home',
            name: 'home',
            builder: (BuildContext context, GoRouterState state) =>
                const HomeScreen(),
          ),
          GoRoute(
            path: '/taskDetail/:taskId',
            builder: (context, state) {
              final taskId = state.pathParameters['taskId']!;

              return DetailScreen(taskId: taskId);
            },
          ),
          // GoRoute(
          //   path: '/login',
          //   name: 'login',
          //   builder: (BuildContext context, GoRouterState state) =>
          //       const LoginScreen(),
          // ),
          // GoRoute(
          //   path: '/signup',
          //   name: 'signup',
          //   builder: (BuildContext context, GoRouterState state) =>
          //       const SignupScreen(),
          // ),
          // GoRoute(
          //   path: '/taskDetails',
          //   name: 'taskDetails',
          //   builder: (BuildContext context, GoRouterState state) {
          //     final isSalesperson =
          //         state.uri.queryParameters['isSalesperson'] == 'true';
          //     final isNewTask =
          //         state.uri.queryParameters['isNewTask'] == 'true';
          //     final dealNo = state.uri.queryParameters['dealNo'] ?? '';
          //
          //     return TaskDetailScreen(
          //       isNewTask: isNewTask,
          //       dealNo: dealNo,
          //       isSalesperson: isSalesperson,
          //     );
          //   },
          // ),
          // GoRoute(
          //   path: '/taskList',
          //   name: 'taskList',
          //   builder: (BuildContext context, GoRouterState state) =>
          //       const TaskListPage(),
          // ),
          // GoRoute(
          //   path: '/notifications',
          //   name: 'notifications',
          //   builder: (BuildContext context, GoRouterState state) =>
          //       const NotificationScreen(),
          // ),
          // GoRoute(
          //   path: '/measurement',
          //   name: 'measurement',
          //   builder: (BuildContext context, GoRouterState state) =>
          //       const MeasurementScreen(),
          // ),
          // GoRoute(
          //   path: '/measurement2',
          //   name: 'measurement2',
          //   builder: (BuildContext context, GoRouterState state) =>
          //       const MeasurementScreen2(),
          // ),
          // GoRoute(
          //   path: '/quotation',
          //   name: 'quotation',
          //   builder: (BuildContext context, GoRouterState state) =>
          //       const QuotationScreen(),
          // ),
        ],
      );
}

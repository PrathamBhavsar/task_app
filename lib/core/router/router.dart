import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../old/views/auth/login_screen.dart';
import '../../old/views/auth/signup_screen.dart';
import '../../old/views/home/pages/notification/notification_screen.dart';
import '../../old/views/home/pages/task list/task_list_page.dart';
import '../../old/views/task/task_detail_screen.dart';
import '../../old/views/task/widgets/measurement/measurement_screen.dart';
import '../../old/views/task/widgets/measurement/measurement_screen_2.dart';
import '../../old/views/task/widgets/quotation/quotation_screen.dart';
import '../../presentation/providers/task_provider.dart';
import '../../presentation/screens/splash/splash_screen.dart';
import '../../presentation/screens/home/dash.dart';
import '../../presentation/screens/task/detail.dart';

abstract class MyRouter {
  static GoRouter router(bool isLoggedIn) => GoRouter(
        initialLocation: true
            // ? '/taskDetails?isSalesperson=false&isNewTask=false&dealNo=25-0019'
            ? '/home'
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
                const Home(),
          ),
          GoRoute(
            path: '/taskDetail/:taskId',
            builder: (context, state) {
              final taskId = state.pathParameters['taskId']!;

              final task = context
                  .read<TaskProvider>()
                  .tasks
                  .firstWhere((task) => task.id == taskId);

              return DetailScreen(task: task);
            },
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
            path: '/measurement2',
            name: 'measurement2',
            builder: (BuildContext context, GoRouterState state) =>
                const MeasurementScreen2(),
          ),
          GoRoute(
            path: '/quotation',
            name: 'quotation',
            builder: (BuildContext context, GoRouterState state) =>
                const QuotationScreen(),
          ),
        ],
      );
}

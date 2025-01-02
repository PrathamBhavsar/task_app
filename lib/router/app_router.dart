import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_app/views/auth/login_screen.dart';
import 'package:task_app/views/auth/signup_screen.dart';
import 'package:task_app/views/home/home_screen.dart';
import 'package:task_app/views/home/pages/task%20list/task_list_page.dart';
import 'package:task_app/views/task/task_detail_screen.dart';

abstract class MyRouter {
  static GoRouter router(bool isLoggedIn) {
    return GoRouter(initialLocation: isLoggedIn ? '/home' : '/home', routes: [
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
        builder: (BuildContext context, GoRouterState state) =>
            const TaskDetailScreen(),
      ),
      GoRoute(
        path: '/taskList',
        name: 'taskList',
        builder: (BuildContext context, GoRouterState state) =>
            const TaskListPage(),
      ),
    ]);
  }
}

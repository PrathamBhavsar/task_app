import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_app/views/auth/login_screen.dart';
import 'package:task_app/views/auth/signup_screen.dart';
import 'package:task_app/views/home/home_screen.dart';

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
    ]);
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:task_app/constants/app_colors.dart';

class NavigationText extends StatelessWidget {
  final bool isLogin;

  const NavigationText({super.key, required this.isLogin});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
      child: Center(
        child: RichText(
          text: TextSpan(
            text: isLogin
                ? "Already have an account? "
                : "Don't have an account? ",
            style: const TextStyle(
              color: AppColors.accent,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: isLogin ? "Log in" : "Sign up",
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w900,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    context.goNamed(isLogin ? 'login' : 'signup');
                  },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

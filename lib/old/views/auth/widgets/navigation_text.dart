import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_consts.dart';

class NavigationText extends StatelessWidget {
  final bool isLogin;

  const NavigationText({super.key, required this.isLogin});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
        child: Center(
          child: RichText(
            text: TextSpan(
              text: isLogin
                  ? "Already have an account? "
                  : "Don't have an account? ",
              style: TextStyle(
                color: AppColors.accent,
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: isLogin ? "Log in" : "Sign up",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 15.sp,
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

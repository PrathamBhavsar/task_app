import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../utils/constants/custom_icons.dart';

import '../../../utils/constants/app_constants.dart';
import '../../../utils/extensions/padding.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../widgets/action_button.dart';
import '../../widgets/custom_text_field.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state.status == AuthStatus.success) {
                        context.go(AppRoutes.home);
                      }
                    },
                    builder: (context, state) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            CustomIcon.package,
                            color: Colors.black,
                            size: 60.sp,
                          ),
                          Text(
                            'Floww.',
                            style: AppTexts.titleTextStyle.copyWith(
                              fontSize: 30.sp,
                              fontVariations: [FontVariation.weight(900)],
                            ),
                            softWrap: true,
                          ),
                          40.hGap,
                          Text(
                            'Sign in to your account to continue',
                            style: AppTexts.inputHintTextStyle.copyWith(
                              fontSize: 16.sp,
                            ),
                          ),
                          10.hGap,
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Email',
                              style: AppTexts.labelTextStyle,
                            ),
                          ),
                          10.hGap,
                          CustomTextField(
                            controller: emailController,
                            hintTxt: 'name@example.com',
                            keyboardType: TextInputType.emailAddress,
                            isEnabled: state.status != AuthStatus.loading,
                          ),
                          10.hGap,
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Password',
                              style: AppTexts.labelTextStyle,
                            ),
                          ),
                          10.hGap,
                          CustomTextField(
                            controller: passController,
                            keyboardType: TextInputType.visiblePassword,
                            isPassword: true,
                            isEnabled: state.status != AuthStatus.loading,
                          ),
                          10.hGap,
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Select your role',
                              style: AppTexts.labelTextStyle,
                            ),
                          ),
                          10.hGap,
                          ActionButton(
                            backgroundColor: Colors.black,
                            label: 'Log In',
                            fontColor: Colors.white,
                            isDisabled: state.status == AuthStatus.loading,
                            onPress:
                                () => context.read<AuthBloc>().add(
                                  LoginEvent(
                                    email: emailController.text,
                                    password: passController.text,
                                  ),
                                ),
                          ),
                        ],
                      );
                    },
                  ).padAll(AppPaddings.appPaddingInt),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

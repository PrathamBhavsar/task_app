import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../utils/constants/custom_icons.dart';

import '../../../utils/constants/app_constants.dart';
import '../../../utils/extensions/padding.dart';
import '../../providers/auth_provider.dart';
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
  Widget build(BuildContext context) => Scaffold(
    resizeToAvoidBottomInset: true,
    body: GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: LayoutBuilder(
          builder:
              (context, constraints) => SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Column(
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
                        child: Text('Email', style: AppTexts.labelTextStyle),
                      ),
                      10.hGap,
                      CustomTextField(
                        controller: emailController,
                        hintTxt: 'name@example.com',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      10.hGap,
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Password', style: AppTexts.labelTextStyle),
                      ),
                      10.hGap,
                      CustomTextField(
                        controller: passController,
                        keyboardType: TextInputType.visiblePassword,
                        isPassword: true,
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
                      Consumer<AuthProvider>(
                        builder:
                            (context, provider, child) => Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Radio(
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      activeColor: Colors.black,
                                      value: 'Admin',
                                      groupValue: provider.selectedRole,
                                      onChanged: (value) {
                                        provider.setRole(value as String);
                                      },
                                    ),
                                    Text(
                                      'Admin',
                                      style: AppTexts.inputTextStyle,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      activeColor: Colors.black,
                                      value: 'Salesperson',
                                      groupValue: provider.selectedRole,
                                      onChanged: (value) {
                                        provider.setRole(value as String);
                                      },
                                    ),
                                    Text(
                                      'Salesperson',
                                      style: AppTexts.inputTextStyle,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      activeColor: Colors.black,
                                      value: 'Agency',
                                      groupValue: provider.selectedRole,
                                      onChanged: (value) {
                                        provider.setRole(value as String);
                                      },
                                    ),
                                    Text(
                                      'Agency',
                                      style: AppTexts.inputTextStyle,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                      ),
                      10.hGap,
                      ActionButton(
                        backgroundColor: Colors.black,
                        label: 'Sign In',
                        fontColor: Colors.white,
                        onPress:
                            () => context.pushReplacement(AppRoutes.splash),
                      ),
                    ],
                  ).padAll(AppPaddings.appPaddingInt),
                ),
              ),
        ),
      ),
    ),
  );
}

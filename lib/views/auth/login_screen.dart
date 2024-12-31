import 'package:flutter/material.dart';
import 'package:task_app/constants/app_colors.dart';
import 'package:task_app/views/auth/widgets/navigation_text.dart';
import 'package:task_app/widgets/action_button.dart';
import 'package:task_app/widgets/custom_text_feild.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  final emailFocusNode = FocusNode();
  final passFocusNode = FocusNode();

  @override
  void dispose() {
    for (var controller in [emailController, passController]) {
      controller.dispose();
    }
    for (var focusNode in [emailFocusNode, passFocusNode]) {
      focusNode.dispose();
    }
    super.dispose();
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String label,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    bool isPassword = false,
  }) {
    return CustomTextField(
      controller: controller,
      focusNode: focusNode,
      labelTxt: label,
      hintTxt: hint,
      keyboardType: keyboardType,
      isPassword: isPassword,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Padding(
          padding: AppPaddings.appPadding,
          child: Column(
            children: [
              AppPaddings.gapH(200),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Log into your Account!',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: AppTexts.fW900,
                  ),
                ),
              ),
              AppPaddings.gapH(20),
              _buildTextField(
                controller: emailController,
                focusNode: emailFocusNode,
                label: "Email",
                hint: "Enter your email",
                keyboardType: TextInputType.emailAddress,
              ),
              AppPaddings.gapH(10),
              _buildTextField(
                controller: passController,
                focusNode: passFocusNode,
                label: "Password",
                hint: "Enter your password",
                keyboardType: TextInputType.visiblePassword,
                isPassword: true,
              ),
              const Spacer(),
              const NavigationText(isLogin: false),
              AppPaddings.gapH(10),
              ActionBtn(
                btnTxt: 'Log in',
                onPress: () {},
                fontColor: AppColors.primary,
                backgroundColor: AppColors.orange,
              ),
              AppPaddings.gapH(10),
            ],
          ),
        ),
      ),
    );
  }
}

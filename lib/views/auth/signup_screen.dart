import 'package:flutter/material.dart';
import 'package:task_app/constants/app_colors.dart';
import 'package:task_app/controllers/auth_controller.dart';
import 'package:task_app/providers/auth_provider.dart';
import 'package:task_app/views/auth/widgets/navigation_text.dart';
import 'package:task_app/views/auth/widgets/user_role_widget.dart';
import 'package:task_app/widgets/action_button.dart';
import 'package:task_app/widgets/custom_text_feild.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passController = TextEditingController();

  final nameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();
  final passFocusNode = FocusNode();

  @override
  void dispose() {
    for (var controller in [
      nameController,
      emailController,
      phoneController,
      passController
    ]) {
      controller.dispose();
    }
    for (var focusNode in [
      nameFocusNode,
      emailFocusNode,
      phoneFocusNode,
      passFocusNode
    ]) {
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
    bool isPhone = false,
  }) {
    return CustomTextField(
      controller: controller,
      focusNode: focusNode,
      labelTxt: label,
      hintTxt: hint,
      keyboardType: keyboardType,
      isPassword: isPassword,
      isPhone: isPhone,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: IntrinsicHeight(
              child: Padding(
                padding: AppPaddings.appPadding,
                child: Column(
                  children: [
                    AppPaddings.gapH(200),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Create an Account!',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: AppTexts.fW700,
                        ),
                      ),
                    ),
                    AppPaddings.gapH(20),
                    _buildTextField(
                      controller: nameController,
                      focusNode: nameFocusNode,
                      label: "Name",
                      hint: "Enter your name",
                    ),
                    AppPaddings.gapH(10),
                    _buildTextField(
                      controller: phoneController,
                      focusNode: phoneFocusNode,
                      label: "Phone",
                      hint: "Enter your phone",
                      keyboardType: TextInputType.phone,
                      isPhone: true,
                    ),
                    AppPaddings.gapH(10),
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
                    AppPaddings.gapH(10),
                    const UserRoleWidget(),
                    const SizedBox(height: 20),
                    Expanded(
                      child: SizedBox(),
                    ),
                    const NavigationText(isLogin: true),
                    AppPaddings.gapH(10),
                    ActionBtn(
                      btnTxt: 'Sign Up',
                      onPress: () async {
                        await AuthController.instance.signUp(
                          context: context,
                          name: nameController.text,
                          email: emailController.text,
                          password: passController.text,
                          role: AuthProvider.instance.currentUserRole,
                        );
                      },
                      fontColor: AppColors.primary,
                      backgroundColor: AppColors.orange,
                    ),
                    AppPaddings.gapH(10),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

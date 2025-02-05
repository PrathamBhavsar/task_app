import 'package:flutter/material.dart';
import '../../constants/app_consts.dart';
import '../../controllers/auth_controller.dart';
import '../../extensions/app_paddings.dart';
import 'widgets/navigation_text.dart';
import '../../widgets/action_button.dart';
import '../../widgets/custom_text_field.dart';

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
  }) =>
      CustomTextField(
        controller: controller,
        focusNode: focusNode,
        labelTxt: label,
        hintTxt: hint,
        keyboardType: keyboardType,
        isPassword: isPassword,
      );

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerTheme: const DividerThemeData(
              color: Colors.transparent,
            ),
          ),
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
                        200.hGap,
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Log into your Account!',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        20.hGap,
                        _buildTextField(
                          controller: emailController,
                          focusNode: emailFocusNode,
                          label: "Email",
                          hint: "Enter your email",
                          keyboardType: TextInputType.emailAddress,
                        ),
                        10.hGap,
                        _buildTextField(
                          controller: passController,
                          focusNode: passFocusNode,
                          label: "Password",
                          hint: "Enter your password",
                          keyboardType: TextInputType.visiblePassword,
                          isPassword: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            persistentFooterButtons: [
              Column(
                children: [
                  const NavigationText(isLogin: false),
                  10.hGap,
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                    child: ActionBtn(
                      btnTxt: 'Log in',
                      onPress: () async {
                        await AuthController.instance.login(
                          context: context,
                          email: emailController.text,
                          password: passController.text,
                        );
                      },
                      fontColor: AppColors.primary,
                      backgroundColor: AppColors.orange,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
}

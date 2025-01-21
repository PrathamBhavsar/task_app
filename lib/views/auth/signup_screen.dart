import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../controllers/auth_controller.dart';
import '../../providers/auth_provider.dart';
import 'widgets/navigation_text.dart';
import 'widgets/user_role_widget.dart';
import '../../widgets/action_button.dart';
import '../../widgets/custom_text_feild.dart';

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
  }) =>
      CustomTextField(
        controller: controller,
        focusNode: focusNode,
        labelTxt: label,
        hintTxt: hint,
        keyboardType: keyboardType,
        isPassword: isPassword,
        isPhone: isPhone,
      );

  @override
  Widget build(BuildContext context) => GestureDetector(
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
                              fontWeight: FontWeight.w700,
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
            persistentFooterButtons: [
              Column(
                children: [
                  const NavigationText(isLogin: true),
                  AppPaddings.gapH(10),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                    child: ActionBtn(
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
                  ),
                ],
              )
            ]),
      );
}

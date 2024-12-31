import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:task_app/constants/app_colors.dart';
import 'package:task_app/providers/auth_provider.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.labelTxt,
    this.hintTxt,
    this.keyboardType,
    this.isPassword = false,
    this.isPhone = false,
    this.isEnabled = true,
    this.prefixIcon,
    this.onChangedFunc,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? labelTxt;
  final String? hintTxt;
  final TextInputType? keyboardType;
  final bool isPassword;
  final bool isPhone;
  final bool isEnabled;
  final Icon? prefixIcon;
  final Function(String)? onChangedFunc;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, provider, child) {
        return TextField(
          controller: controller,
          focusNode: focusNode,
          enabled: isEnabled,
          obscureText: isPassword ? !provider.isVisible : false,
          onChanged: onChangedFunc,
          keyboardType: keyboardType ?? TextInputType.text,
          inputFormatters: isPhone
              ? [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ]
              : null,
          style: _textStyle(AppColors.primary, 18, AppTexts.fW900),
          textAlignVertical: TextAlignVertical.center,
          decoration: _buildInputDecoration(provider),
        );
      },
    );
  }

  InputDecoration _buildInputDecoration(AuthProvider provider) {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      prefixIcon: prefixIcon,
      prefixIconColor: AppColors.primary,
      suffixIcon: isPassword
          ? IconButton(
              icon: Icon(
                weight: 20,
                provider.isVisible
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: AppColors.primary,
              ),
              onPressed: provider.toggleVisibility,
            )
          : null,
      fillColor: AppColors.textFieldBg,
      filled: true,
      prefixText: isPhone ? "+91 " : null,
      prefixStyle: _textStyle(AppColors.primary, 18, FontWeight.w900),
      labelText: labelTxt,
      labelStyle: _textStyle(AppColors.primary, 18, FontWeight.w900),
      hintText: hintTxt,
      hintStyle: _textStyle(AppColors.accent, 18, FontWeight.w900),
      border: _outlineInputBorder(BorderSide.none),
      focusedErrorBorder: _outlineInputBorder(
        const BorderSide(width: 2, color: AppColors.error),
      ),
      focusedBorder: _outlineInputBorder(
        const BorderSide(width: 2, color: AppColors.primary),
      ),
    );
  }

  TextStyle _textStyle(Color color, double fontSize, FontWeight fontWeight) {
    return TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight);
  }

  OutlineInputBorder _outlineInputBorder(BorderSide borderSide) {
    return OutlineInputBorder(
      borderSide: borderSide,
      borderRadius: AppTexts.borderRadius,
    );
  }
}

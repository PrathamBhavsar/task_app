import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../utils/constants/app_constants.dart';
import '../providers/auth_provider.dart';

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
    this.isMultiline = false,
    this.prefixIcon,
    this.onChangedFunc,
    this.onTap,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? labelTxt;
  final String? hintTxt;
  final TextInputType? keyboardType;
  final bool isPassword;
  final bool isPhone;
  final bool isEnabled;
  final bool isMultiline;
  final Icon? prefixIcon;
  final Function(String)? onChangedFunc;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => Consumer<AuthProvider>(
    builder:
        (context, provider, child) => TextField(
          autofocus: false,
          controller: controller,
          focusNode: focusNode,
          enabled: isEnabled,
          maxLines: isMultiline ? null : 1,
          obscureText: isPassword ? !provider.isVisible : false,
          onChanged: onChangedFunc,
          onTap: onTap,
          keyboardType: keyboardType ?? TextInputType.text,
          inputFormatters:
              isPhone
                  ? [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ]
                  : null,
          style: AppTexts.inputTextStyle,
          textAlignVertical: TextAlignVertical.center,
          decoration: _buildInputDecoration(provider),
        ),
  );

  InputDecoration _buildInputDecoration(AuthProvider provider) =>
      InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        prefixIcon: prefixIcon,
        prefixIconColor: AppColors.primary,
        suffixIcon:
            isPassword
                ? IconButton(
                  icon: Icon(
                    weight: 20,
                    provider.isVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: AppColors.accent,
                  ),
                  onPressed: provider.toggleVisibility,
                )
                : null,
        prefixText: isPhone ? "+91 " : null,
        prefixStyle: AppTexts.inputLabelTextStyle,
        labelText: labelTxt,
        labelStyle: AppTexts.inputLabelTextStyle,
        hintText: hintTxt,
        hintStyle: AppTexts.inputHintTextStyle,

        border: AppBorders.outlineTFBorder(
          const BorderSide(width: 1, color: AppColors.accent),
        ),
        focusedErrorBorder: AppBorders.outlineTFBorder(
          const BorderSide(width: 2, color: Colors.red),
        ),
        focusedBorder: AppBorders.outlineTFBorder(
          const BorderSide(width: 2, color: AppColors.accent),
        ),
      );
}

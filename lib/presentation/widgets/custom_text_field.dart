import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/constants/app_constants.dart';
import '../../utils/constants/custom_icons.dart';
import '../blocs/auth/auth_bloc.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.labelTxt,
    this.hintTxt,
    this.keyboardType,
    this.isPassword = false,
    this.isSearch = false,
    this.isPhone = false,
    this.isEnabled = true,
    this.isMultiline = false,
    this.prefixIcon,
    this.onChangedFunc,
    this.onTap,
    this.validator,
    this.onEditingCompleteFunc,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? labelTxt;
  final String? hintTxt;
  final TextInputType? keyboardType;
  final bool isPassword;
  final bool isPhone;
  final bool isSearch;
  final bool isEnabled;
  final bool isMultiline;
  final Icon? prefixIcon;
  final Function(String)? onChangedFunc;
  final void Function()? onEditingCompleteFunc;
  final VoidCallback? onTap;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return SizedBox(
          height: 50.h,
          width: double.infinity,
          child: TextFormField(
            autofocus: false,
            controller: controller,
            validator: validator,
            focusNode: focusNode,
            enabled: isEnabled,
            maxLines: isMultiline ? null : 1,
            obscureText: isPassword ? !state.isVisible : false,
            onChanged: onChangedFunc,
            onEditingComplete: onEditingCompleteFunc,
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
            decoration: _buildInputDecoration(
              state.isVisible,
              () => context.read<AuthBloc>().add(ToggleVisibilityEvent()),
            ),
          ),
        );
      },
    );
  }

  InputDecoration _buildInputDecoration(bool isVisible, Function() onTap) =>
      InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        prefixIcon:
            isSearch
                ? Icon(
                  CustomIcon.search,
                  color: AppColors.lighterBlackBg,
                  size: 20.sp,
                )
                : null,
        prefixIconColor: AppColors.primary,
        suffixIcon:
            isPassword
                ? IconButton(
                  icon: Icon(
                    weight: 20,
                    isVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: AppColors.accent,
                  ),
                  onPressed: onTap,
                )
                : null,
        prefixText: isPhone ? "+91 " : null,
        prefixStyle: AppTexts.inputLabelTextStyle,
        labelText: labelTxt,
        labelStyle: AppTexts.inputLabelTextStyle,
        hintText: hintTxt,
        hintStyle: AppTexts.inputHintTextStyle,
        enabledBorder: AppBorders.outlineTFBorder(
          const BorderSide(width: 1, color: AppColors.accent),
        ),
        disabledBorder: AppBorders.outlineTFBorder(
          const BorderSide(width: 1, color: AppColors.accent),
        ),
        focusedErrorBorder: AppBorders.outlineTFBorder(
          const BorderSide(width: 2, color: Colors.red),
        ),
        focusedBorder: AppBorders.outlineTFBorder(const BorderSide(width: 2)),
      );
}

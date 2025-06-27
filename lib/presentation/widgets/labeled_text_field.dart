import 'package:flutter/material.dart';

import '../../utils/constants/app_constants.dart';
import '../../utils/extensions/padding.dart';
import 'custom_text_field.dart';

class LabeledTextInput extends StatelessWidget {
  const LabeledTextInput({
    required this.title,
    required this.hint,
    super.key,
    this.isMultiline = false,
    this.isEnabled = true,
    this.validator,
    this.controller,
    this.keyboardType,
    this.onChanged,
    this.onEditingComplete,
  });

  final String title;
  final String hint;
  final bool isMultiline;
  final bool isEnabled;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final void Function()? onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTexts.labelTextStyle),
        10.hGap,
        CustomTextField(
          hintTxt: hint,
          isMultiline: isMultiline,
          validator: validator,
          controller: controller,
          keyboardType: keyboardType,
          isEnabled: isEnabled,
          onChangedFunc: onChanged,
          onEditingCompleteFunc: onEditingComplete,
        ),
        10.hGap,
      ],
    );
  }
}

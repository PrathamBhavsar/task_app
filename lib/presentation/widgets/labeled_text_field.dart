import 'package:flutter/material.dart';

import '../../utils/constants/app_constants.dart';
import '../../utils/extensions/padding.dart';
import 'custom_text_field.dart';

class LabeledTextInput extends StatelessWidget {
  const LabeledTextInput({
    super.key,
    required this.title,
    required this.hint,
    this.isMultiline = false,
    this.validator,
    this.controller,
  });

  final String title;
  final String hint;
  final bool isMultiline;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;

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
        ),
        10.hGap,
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/constants/app_constants.dart';

class CustomTag extends StatelessWidget {
  const CustomTag({
    super.key,
    required this.text,
    required this.color,
    required this.textColor,
  });

  final String text;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(15),
    ),
    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
    child: Text(
      text,
      style: AppTexts.inputLabelTextStyle.copyWith(
        color: textColor,
        fontSize: 12.sp,
        fontVariations: [FontVariation.weight(700)],
      ),
      softWrap: true,
      overflow: TextOverflow.visible,
    ),
  );
}

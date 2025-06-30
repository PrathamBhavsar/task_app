import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/constants/app_constants.dart';

class CustomTag extends StatelessWidget {
  const CustomTag({
    required this.text,
    required this.color,
    super.key,
    this.fontColor,
  });

  final String text;
  final Color color;
  final Color? fontColor;

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(8),
    ),
    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
    child: Text(
      text,
      style: AppTexts.inputLabelTextStyle.copyWith(
        color: fontColor ?? Colors.black,
        fontSize: 11.sp,
        fontVariations: [FontVariation.weight(700)],
      ),
      softWrap: true,
      overflow: TextOverflow.visible,
    ),
  );
}

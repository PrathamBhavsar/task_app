import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/app_colors.dart';

class ActionBtn extends StatelessWidget {
  const ActionBtn({
    super.key,
    required this.btnTxt,
    required this.onPress,
    required this.fontColor,
    required this.backgroundColor,
  });

  final String btnTxt;
  final VoidCallback onPress;
  final Color fontColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 60.h,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPress,
          style: ButtonStyle(
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                side: const BorderSide(width: 2),
                borderRadius: AppConsts.radius,
              ),
            ),
            backgroundColor: WidgetStateProperty.all(backgroundColor),
          ),
          child: Text(
            btnTxt,
            style: AppTexts.buttonText.copyWith(
              color: fontColor,
            ),
          ),
        ),
      );
}

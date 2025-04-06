import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/constants/app_constants.dart';
import '../../utils/extensions/padding.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.label,
    required this.onPress,
    this.fontColor = Colors.black,
    this.backgroundColor = Colors.white,
    this.backgroundColorDisabled = Colors.transparent,
    this.isDisabled = false,
    this.hasBorder = true,
    this.prefixIcon,
  });

  final String label;
  final VoidCallback onPress;
  final Color fontColor;
  final Color backgroundColor;
  final Color backgroundColorDisabled;
  final bool isDisabled;
  final bool hasBorder;
  final IconData? prefixIcon;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 50.h,
    width: double.infinity,
    child: ElevatedButton(
      onPressed: isDisabled ? null : onPress,
      style: ButtonStyle(
        elevation: WidgetStateProperty.all(0),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: AppBorders.radius,
            side:
                hasBorder
                    ? BorderSide(width: 1, color: AppColors.accent)
                    : BorderSide.none,
          ),
        ),
        backgroundColor: WidgetStateProperty.all(
          isDisabled ? backgroundColorDisabled : backgroundColor,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (prefixIcon != null) ...[
            Icon(prefixIcon, color: fontColor, size: 24.sp),
            8.wGap,
          ],
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontVariations: [FontVariation.weight(600)],
                  color: isDisabled ? Colors.black : fontColor,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

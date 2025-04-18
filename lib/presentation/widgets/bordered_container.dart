import 'package:flutter/material.dart';

import '../../utils/constants/app_constants.dart';

class BorderedContainer extends StatelessWidget {
  const BorderedContainer({
    super.key,
    required this.child,
    this.padding,
    this.color = Colors.white,
    this.isSelected = false,
  });

  final Widget child;
  final double? padding;
  final Color? color;
  final bool isSelected;

  @override
  Widget build(BuildContext context) => Material(
    color: Colors.transparent,
    child: Ink(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: AppBorders.radius,
        border:
            isSelected
                ? Border.all(color: Colors.black, width: 2)
                : Border.all(color: AppColors.accent, width: 1),
      ),
      padding: EdgeInsets.all(padding ?? AppPaddings.appPaddingInt),
      child: child,
    ),
  );
}

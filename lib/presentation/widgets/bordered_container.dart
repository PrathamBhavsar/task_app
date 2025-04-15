import 'package:flutter/material.dart';

import '../../utils/constants/app_constants.dart';

class BorderedContainer extends StatelessWidget {
  const BorderedContainer({
    super.key,
    required this.child,
    this.padding,
    this.color = Colors.white,
  });

  final Widget child;
  final double? padding;
  final Color? color;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: () {},
    splashColor: AppColors.accent,
    borderRadius: AppBorders.radius,
    child: Material(
      color: Colors.transparent,
      child: Ink(
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: AppBorders.radius,
          border: Border.all(color: AppColors.accent, width: 1),
        ),
        padding: EdgeInsets.all(padding ?? AppPaddings.appPaddingInt),
        child: child,
      ),
    ),
  );
}

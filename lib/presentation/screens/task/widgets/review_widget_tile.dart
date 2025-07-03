import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/constants/app_constants.dart';
import '../../../widgets/action_button.dart';
import '../../../widgets/bordered_container.dart';

class ReviewWidgetTile extends StatelessWidget {
  const ReviewWidgetTile({
    required this.title,
    required this.subtitle,
    required this.btnText,
    required this.onTap,
    super.key,
    this.child,
  });

  final String title;
  final String subtitle;
  final String btnText;
  final void Function() onTap;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return BorderedContainer(
      color: AppColors.bgYellow,
      child: Column(
        spacing: 10.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTexts.headingTextStyle),
          Text(subtitle, style: AppTexts.inputTextStyle),
          ActionButton(
            label: btnText,
            onPress: onTap,
            backgroundColor: Colors.black,
            fontColor: Colors.white,
          ),
          child ?? SizedBox.shrink(),
        ],
      ),
    );
  }
}

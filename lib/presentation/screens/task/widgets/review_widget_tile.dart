import 'package:flutter/material.dart';

import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/extensions/padding.dart';
import '../../../widgets/action_button.dart';
import '../../../widgets/bordered_container.dart';

class ReviewWidgetTile extends StatelessWidget {
  const ReviewWidgetTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.btnText,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final String btnText;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return BorderedContainer(
      color: AppColors.bgYellow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTexts.headingTextStyle),
          10.hGap,
          Text(subtitle, style: AppTexts.inputTextStyle),
          10.hGap,
          ActionButton(
            label: btnText,
            onPress: onTap,
            backgroundColor: Colors.black,
            fontColor: Colors.white,
          ),
        ],
      ),
    );
  }
}

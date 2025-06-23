import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../domain/entities/timeline.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/extensions/color_translator.dart';
import '../../../../utils/extensions/date_formatter.dart';
import '../../../widgets/custom_tag.dart';

class TimelineTile extends StatelessWidget {
  const TimelineTile({required this.timeline, super.key});

  final Timeline timeline;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: Text(timeline.status.name, style: AppTexts.labelTextStyle),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: Text(
                "By ${timeline.user.name}",
                style: AppTexts.inputHintTextStyle,
              ),
            ),
          ],
        ),
        CustomTag(
          text: timeline.createdAt.toPrettyDateTime(),
          color: timeline.status.color.toColor(),
          textColor: Colors.white,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../domain/entities/message.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/extensions/date_formatter.dart';
import '../../../../utils/extensions/padding.dart';
import '../../../widgets/bordered_container.dart';

class MessageTile extends StatelessWidget {
  const MessageTile({required this.message, super.key});

  final Message message;

  @override
  Widget build(BuildContext context) {
    return BorderedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(message.user.name, style: AppTexts.labelTextStyle),
              10.wGap,
              Text(
                message.createdAt.toPrettyDateTime(),
                style: AppTexts.inputHintTextStyle,
              ),
            ],
          ),
          5.hGap,
          Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: Text(message.message, style: AppTexts.inputLabelTextStyle),
          ),
        ],
      ),
    );
  }
}

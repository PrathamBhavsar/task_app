import 'package:flutter/material.dart';
import '../../../../../../core/constants/app_consts.dart';
import '../../../../../extensions/app_paddings.dart';
import '../../../../../providers/task_provider.dart';

class NotificationListTile extends StatelessWidget {
  const NotificationListTile(
      {super.key, required this.color, required this.text, required this.date});
  final Color color;
  final String text;
  final String date;
  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: AppBorders.radius,
          border: Border.all(width: 2),
        ),
        child: Padding(
          padding: AppPaddings.appPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    text,
                    style: AppTexts.headingStyle,
                  ),
                ],
              ),
              8.hGap,
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today_rounded,
                    size: 22,
                  ),
                  8.wGap,
                  Text(
                    TaskProvider.instance.formatDate(date),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      );
}

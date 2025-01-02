import 'package:flutter/material.dart';
import 'package:task_app/constants/app_colors.dart';
import 'package:task_app/providers/task_provider.dart';

class NotificationListTile extends StatelessWidget {
  const NotificationListTile(
      {super.key, required this.color, required this.text, required this.date});
  final Color color;
  final String text;
  final String date;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
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
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: AppTexts.fW900,
                  ),
                ),
              ],
            ),
            AppPaddings.gapH(8),
            Row(
              children: [
                const Icon(
                  Icons.calendar_today_rounded,
                  size: 22,
                ),
                AppPaddings.gapW(8),
                Text(
                  TaskProvider.instance.formatDate(date),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: AppTexts.fW900,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

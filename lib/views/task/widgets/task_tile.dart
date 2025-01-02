import 'package:flutter/material.dart';
import 'package:task_app/constants/app_colors.dart';
import 'package:task_app/providers/task_provider.dart';
import 'package:task_app/views/home/pages/task%20list/widgets/overlapping_circles.dart';
import 'package:task_app/widgets/circle_icons.dart';
import 'package:task_app/widgets/custom_tag.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.tasks});
  final Map<String, dynamic> tasks;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
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
                  tasks['name'],
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: AppTexts.fW900,
                  ),
                ),
                CircleIcons(
                  icon: Icons.more_horiz_rounded,
                  onTap: () {},
                ),
              ],
            ),
            Row(
              children: [
                CustomTag(
                  color: AppColors.green,
                  text: tasks['priority'],
                ),
                AppPaddings.gapW(8),
                CustomTag(
                  color: AppColors.pink,
                  text: tasks['status'],
                ),
              ],
            ),
            AppPaddings.gapH(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_rounded,
                      size: 22,
                    ),
                    AppPaddings.gapW(8),
                    Text(
                      TaskProvider.instance.formatDate(tasks['due_date']),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: AppTexts.fW900,
                      ),
                    )
                  ],
                ),
                const OverlappingCircles(numberOfCircles: 3),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

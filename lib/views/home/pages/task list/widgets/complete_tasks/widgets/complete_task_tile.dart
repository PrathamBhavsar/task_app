import 'package:flutter/material.dart';
import 'package:task_app/constants/app_colors.dart';
import 'package:task_app/views/home/pages/task%20list/widgets/overlapping_circles.dart';
import 'package:task_app/widgets/circle_icons.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({super.key});

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
                const Text(
                  'Dashboard Design for Admin',
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
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(width: 2),
                    borderRadius: BorderRadius.circular(25),
                    color: AppColors.green,
                  ),
                  child: const Text(
                    'Low',
                    style: TextStyle(
                      fontWeight: AppTexts.fW900,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                AppPaddings.gapW(8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(width: 2),
                    borderRadius: BorderRadius.circular(25),
                    color: AppColors.pink,
                  ),
                  child: const Text(
                    'Meeting',
                    style: TextStyle(
                      fontWeight: AppTexts.fW900,
                      color: AppColors.primary,
                    ),
                  ),
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
                    const Text(
                      '14 Oct, 2024',
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

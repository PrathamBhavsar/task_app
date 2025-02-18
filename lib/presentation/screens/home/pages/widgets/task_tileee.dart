import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/constants/app_consts.dart';
import '../../../../../data/models/task.dart';
import '../../../../../old/extensions/app_paddings.dart';
import '../../../../../old/providers/task_provider.dart';
import '../../../../../old/views/home/pages/task list/widgets/overlapping_circles.dart';
import '../../../../../old/widgets/circle_icons.dart';
import '../../../../../old/widgets/custom_tag.dart';

class TaskTile1 extends StatelessWidget {
  const TaskTile1({super.key, required this.task, this.isSalesperson = true});

  final Task task;
  final bool isSalesperson;

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            context.push('/taskDetails?isNewTask=true');
          },
          splashColor: AppColors.primary.withOpacity(0.1),
          child: Container(
            height: 148.h,
            decoration: BoxDecoration(
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
                        task.name,
                        style: AppTexts.headingStyle,
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
                        text: task.priority ?? '',
                      ),
                      8.wGap,
                      CustomTag(
                        color: AppColors.pink,
                        text: task.status ?? '',
                      ),
                    ],
                  ),
                  8.hGap,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today_rounded,
                            size: 22,
                          ),
                          8.wGap,
                          Text(
                            TaskProvider.instance.formatDate(task.dueDate),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        ],
                      ),
                      OverlappingCircles(
                          bgColors: [AppColors.orange, AppColors.pink],
                          displayNames: ['AppColors.orange', 'AppColors.pink']),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

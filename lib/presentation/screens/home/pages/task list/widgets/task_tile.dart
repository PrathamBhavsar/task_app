import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../../data/models/task.dart';
import '../../../../../../data/models/taskWithUser.dart';
import '../../../../../../utils/constants/app_consts.dart';
import '../../../../../../utils/extensions/app_paddings.dart';
import '../../../../../../utils/extensions/color_extension.dart';
import '../../../../../../utils/extensions/format_date.dart';
import 'circle_icons.dart';
import '../../widgets/custom_tag.dart';
import 'overlapping_circles.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.task});

  final TaskWithUsers task;

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => context.push('/taskDetail/${task.taskId}'),
          splashColor: AppColors.primary.withValues(alpha: 0.1),
          child: Container(
            height: 148.h,
            decoration: BoxDecoration(
              borderRadius: AppBorders.radius,
              border: Border.all(width: 2),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(task.taskName, style: AppTexts.headingStyle),
                    Skeleton.ignore(
                        child: CircleIcons(
                            icon: Icons.more_horiz_rounded, onTap: () {})),
                  ],
                ),
                Row(
                  children: [
                    CustomTag(
                        color: task.priorityColor.toColor(),
                        text: task.priorityName),
                    8.wGap,
                    CustomTag(
                        color: task.statusColor.toColor(),
                        text: task.statusName),
                  ],
                ),
                8.hGap,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.calendar_today_rounded, size: 22),
                        8.wGap,
                        Text(
                          task.dueDate.formatDate(),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    OverlappingCircles(
                        bgColors: task.userProfileBgColors,
                        // users
                        //     .map((user) =>
                        //         Color(int.parse(user.profileBgColor, radix: 16)))
                        //     .toList(),
                        displayNames: task.userNames
                        // users.map((user) => user.name).toList(),
                        ),
                  ],
                ),
              ],
            ).padAll(AppPaddings.appPaddingInt),
          ),
        ),
      );
}

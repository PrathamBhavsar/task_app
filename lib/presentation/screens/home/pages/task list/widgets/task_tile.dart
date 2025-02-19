import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../../../data/models/task.dart';
import '../../../../../../data/models/user.dart';
import '../../../../../../utils/constants/app_consts.dart';
import '../../../../../../utils/extensions/app_paddings.dart';
import '../../../../../../utils/extensions/format_date.dart';
import '../../../../../providers/task_provider.dart';
import 'circle_icons.dart';
import '../../widgets/custom_tag.dart';
import 'overlapping_circles.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);
    final List<User> users = provider.taskUsers[task.id] ?? [];

    return Material(
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(task.name, style: AppTexts.headingStyle),
                  CircleIcons(icon: Icons.more_horiz_rounded, onTap: () {}),
                ],
              ),
              Row(
                children: [
                  CustomTag(color: AppColors.green, text: task.priority ?? ''),
                  8.wGap,
                  CustomTag(color: AppColors.pink, text: task.status ?? ''),
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
                    bgColors: users
                        .map((user) =>
                            Color(int.parse(user.profileBgColor, radix: 16)))
                        .toList(),
                    displayNames: users.map((user) => user.name).toList(),
                  ),
                ],
              ),
            ],
          ).padAll(AppPaddings.appPaddingInt),
        ),
      ),
    );
  }
}

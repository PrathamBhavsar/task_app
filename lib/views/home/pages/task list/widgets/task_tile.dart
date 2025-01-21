import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../constants/app_colors.dart';
import '../../../../../providers/task_provider.dart';
import 'overlapping_circles.dart';
import '../../../../../widgets/circle_icons.dart';
import '../../../../../widgets/custom_tag.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.task, this.isSalesperson = true});

  final Map<String, dynamic> task;
  final bool isSalesperson;

  @override
  Widget build(BuildContext context) => Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          final dealNo = task['deal_no'];
          context.push(
              '/taskDetails?isSalesperson=$isSalesperson&isNewTask=false&dealNo=$dealNo');
        },
        splashColor: AppColors.primary.withOpacity(0.1),
        child: Container(
          height: 148.h,
          decoration: BoxDecoration(
            borderRadius: AppConsts.radius,
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
                      task['name'] ?? '',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: AppTexts.fW700,
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
                      text: task['priority'] ?? '',
                    ),
                    AppPaddings.gapW(8),
                    CustomTag(
                      color: AppColors.pink,
                      text: task['status'] ?? '',
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
                          TaskProvider.instance.formatDate(task['due_date']),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: AppTexts.fW700,
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
// }
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:task_app/constants/app_colors.dart';
// import 'package:task_app/constants/app_keys.dart';
// import 'package:task_app/providers/task_provider.dart';
// import 'package:task_app/views/home/pages/task%20list/widgets/overlapping_circles.dart';
// import 'package:task_app/widgets/circle_icons.dart';
// import 'package:task_app/widgets/custom_tag.dart';
//
// class TaskTile extends StatelessWidget {
//   const TaskTile({super.key, required this.task});
//   final Map<String, dynamic> task;
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         final dealNo = task['deal_no'];
//         context.push('/taskDetails?isNewTask=false&dealNo=$dealNo');
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: AppConsts.radius,
//           border: Border.all(width: 2),
//         ),
//         child: Padding(
//           padding: AppPaddings.appPadding,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     task['name'] ?? '',
//                     style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: AppTexts.fW700,
//                     ),
//                   ),
//                   CircleIcons(
//                     icon: Icons.more_horiz_rounded,
//                     onTap: () {},
//                   ),
//                 ],
//               ),
//               Row(
//                 children: [
//                   CustomTag(
//                     color: AppColors.green,
//                     text: task['priority'] ?? '',
//                   ),
//                   AppPaddings.gapW(8),
//                   CustomTag(
//                     color: AppColors.pink,
//                     text: task['status'] ?? '',
//                   ),
//                 ],
//               ),
//               AppPaddings.gapH(8),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: [
//                       const Icon(
//                         Icons.calendar_today_rounded,
//                         size: 22,
//                       ),
//                       AppPaddings.gapW(8),
//                       Text(
//                         TaskProvider.instance.formatDate(task['due_date']),
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: AppTexts.fW700,
//                         ),
//                       )
//                     ],
//                   ),
//                   OverlappingCircles(
//                     bgColors: TaskProvider.instance
//                         .getUserDetails(
//                             (task[TaskKeys.taskUserIds] as List<dynamic>)
//                                 .cast<String>())
//                         .map(
//                           (user) => TaskProvider.instance.stringToColor(
//                             user[UserDetails.profileBgColor],
//                           ),
//                         )
//                         .toList(),
//                     displayNames: TaskProvider.instance
//                         .getUserDetails(
//                             (task[TaskKeys.taskUserIds] as List<dynamic>)
//                                 .cast<String>())
//                         .map((user) => user[UserDetails.name] as String)
//                         .toList(),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../constants/app_consts.dart';
import '../../../../../extensions/app_paddings.dart';
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
                        task['name'] ?? '',
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
                        text: task['priority'] ?? '',
                      ),
                      8.wGap,
                      CustomTag(
                        color: AppColors.pink,
                        text: task['status'] ?? '',
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
                            TaskProvider.instance.formatDate(task['due_date']),
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
// }
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:task_app/constants/app_consts.dart';
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
//                       fontWeight: FontWeight.w700,
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
//                   8.wGap,
//                   CustomTag(
//                     color: AppColors.pink,
//                     text: task['status'] ?? '',
//                   ),
//                 ],
//               ),
//               8.hGap,
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: [
//                       const Icon(
//                         Icons.calendar_today_rounded,
//                         size: 22,
//                       ),
//                       8.wGap,
//                       Text(
//                         TaskProvider.instance.formatDate(task['due_date']),
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w700,
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

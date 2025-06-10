import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/di/di.dart';
import '../../../domain/entities/task.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/constants/custom_icons.dart';
import '../../../utils/extensions/padding.dart';
import '../../providers/task_provider.dart';
import '../../providers/user_provider.dart';
import '../../widgets/action_button.dart';
import '../../widgets/tab_header.dart';
import 'widgets/task_tile.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) => Consumer<TaskProvider>(
    builder:
        (context, provider, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('My Tasks', style: AppTexts.titleTextStyle),
                IntrinsicWidth(
                  child: ActionButton(
                    label: 'New Task',
                    onPress: () {
                      getIt<UserProvider>().fetchAllUsers();
                    },
                    // () => context.push(
                    //   AppRoutes.editTask,
                    //   extra: {'task': Task.empty(), 'isNew': true},
                    // ),
                    prefixIcon: CustomIcon.badgePlus,
                    fontColor: Colors.white,
                    backgroundColor: Colors.black,
                  ),
                ),
              ],
            ),
            TabHeader(tabs: [Tab(text: 'Active'), Tab(text: 'Completed')]),
            10.hGap,
            // _buildActiveTasks(
            //   provider.tabIndex == 0 ? Task.pendingTasks : Task.completedTasks,
            // ),
          ],
        ),
  );
  Widget _buildActiveTasks(List<Task> tasks) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ...List.generate(
        tasks.length,
        (index) => Padding(
          padding: index == 0 ? EdgeInsets.zero : EdgeInsets.only(top: 10.h),
          child: TaskTile(task: tasks[index]),
        ),
      ),
    ],
  );
}

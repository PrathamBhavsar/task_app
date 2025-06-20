import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/di/di.dart';
import '../../../domain/entities/task.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/constants/custom_icons.dart';
import '../../../utils/enums/task_status.dart';
import '../../../utils/extensions/padding.dart';
import '../../blocs/tab/tab_bloc.dart';
import '../../blocs/task/task_bloc.dart';
import '../../blocs/task/task_event.dart';
import '../../blocs/task/task_state.dart';
import '../../providers/task_provider.dart';
import '../../providers/user_provider.dart';
import '../../widgets/action_button.dart';
import '../../widgets/tab_header.dart';
import 'widgets/task_tile.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, taskState) {
        if (taskState is TaskLoadInProgress) {
          return const Center(child: CircularProgressIndicator());
        }

        if (taskState is TaskLoadFailure) {
          return const Center(child: Text('There was an issue loading tasks!'));
        }

        if (taskState is TaskLoadSuccess) {
          final tasks = taskState.tasks;

          if (tasks.isEmpty) {
            return const Center(child: Text('There are no tasks!'));
          }

          return Column(
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
              BlocBuilder<TabBloc, TabState>(
                builder: (context, tabState) {
                  // List<Task> selectedTasks =
                  //     tasks
                  //         .where(
                  //           (t) =>
                  //               t.status.name ==
                  //               (tabState.tabIndex == 0
                  //                   ? TaskStatus.pending.status
                  //                   : TaskStatus.rejected.status),
                  //         )
                  //         .toList();

                  return _buildActiveTasks(tasks);
                },
              ),
            ],
          );
        }
        return const Center(child: Text('There are no tasks!'));
      },
    );
  }

  Widget _buildActiveTasks(List<Task> tasks) {
    if (tasks.isEmpty) {
      return const Center(child: Text('There are no tasks with status!'));
    }
    return Column(
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
}

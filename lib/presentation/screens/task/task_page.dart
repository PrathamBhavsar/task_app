import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/task.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/constants/custom_icons.dart';
import '../../../utils/extensions/padding.dart';
import '../../blocs/task/task_bloc.dart';
import '../../blocs/task/task_event.dart';
import '../../blocs/task/task_state.dart';
import '../../widgets/action_button.dart';
import '../../widgets/refresh_wrapper.dart';
import 'widgets/task_tile.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskBloc, TaskState>(
      listener: (context, taskState) {
        if (taskState is PutTaskSuccess || taskState is UpdateTaskSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<TaskBloc>().add(FetchTasksRequested());
          });
        }
      },
      builder: (context, taskState) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('My Tasks', style: AppTexts.titleTextStyle),
                IntrinsicWidth(
                  child: ActionButton(
                    label: 'New Task',
                    onPress:
                        () => context.push(
                          AppRoutes.editTask,
                          extra: {'isNew': true},
                        ),
                    prefixIcon: CustomIcon.badgePlus,
                    fontColor: Colors.white,
                    backgroundColor: Colors.black,
                  ),
                ),
              ],
            ),
            20.hGap,
            Expanded(
              child: RefreshableStateWrapper<Task>(
                state: taskState,
                fetchFunction:
                    () async =>
                        context.read<TaskBloc>().add(FetchTasksRequested()),
                isLoading: (s) => s is TaskLoadInProgress,
                isFailure: (s) => s is TaskLoadFailure,
                getFailureMessage: (s) => (s as TaskLoadFailure).error.message,
                extractItems: (s) => s is TaskLoadSuccess ? s.tasks : [],
                itemBuilder: (context, task) => TaskTile(task: task),
              ),
            ),
          ],
        );
      },
    );
  }
}

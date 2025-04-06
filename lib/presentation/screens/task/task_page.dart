import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../data/models/task.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/extensions/padding.dart';
import '../../providers/home_provider.dart';
import '../../providers/task_provider.dart';
import '../../widgets/bordered_container.dart';
import '../../widgets/custom_tag.dart';
import '../../widgets/tab_header.dart';

List<Task> tasks = Task.sampleTasks;

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) => Consumer<TaskProvider>(
    builder:
        (context, provider, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('My Tasks', style: AppTexts.titleTextStyle),
            10.hGap,
            TabHeader(tabs: [Tab(text: 'Active'), Tab(text: 'Completed')]),
            10.hGap,
            _buildActiveTasks(),
          ],
        ),
  );
  Widget _buildActiveTasks() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ...List.generate(
        tasks.length,
        (index) => Padding(
          padding: index == 0 ? EdgeInsets.zero : EdgeInsets.only(top: 10.h),
          child: BorderedContainer(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(tasks[index].name, style: AppTexts.titleTextStyle),
                    5.hGap,

                    Text(
                      tasks[index].customer,
                      style: AppTexts.inputHintTextStyle,
                    ),

                    tasks[index].agency != null
                        ? Text(
                          "Agency: ${tasks[index].customer}",
                          style: AppTexts.inputHintTextStyle,
                        )
                        : SizedBox.shrink(),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomTag(
                      text: tasks[index].status,
                      color: AppColors.accent,
                      textColor: Colors.black,
                    ),
                    5.hGap,
                    Text(
                      tasks[index].dueDate,
                      style: AppTexts.inputHintTextStyle,
                    ).padSymmetric(horizontal: 10.w),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

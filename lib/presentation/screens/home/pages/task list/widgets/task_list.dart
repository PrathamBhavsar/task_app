import 'package:flutter/material.dart';
import '../../../../../../data/models/task.dart';
import '../../../../../../utils/constants/app_consts.dart';
import '../../../../../../utils/extensions/app_paddings.dart';
import 'task_tile.dart';

class TasksList1 extends StatelessWidget {
  const TasksList1({
    super.key,
    required this.tasksList,
    required this.altText,
  });
  final List<Task> tasksList;
  final String altText;

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: tasksList.length,
        itemBuilder: (BuildContext context, int index) {
          if (tasksList.isEmpty) {
            return Center(
              child: Text(
                altText,
                style: AppTexts.headingStyle,
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: TaskTile(
              task: tasksList[index],
            ),
          );
        },
      ).padAll(AppPaddings.appPaddingInt);
}

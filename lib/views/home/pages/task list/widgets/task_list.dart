import 'package:flutter/material.dart';
import 'package:task_app/constants/app_colors.dart';
import 'package:task_app/views/home/pages/task%20list/widgets/task_tile.dart';

class TasksList extends StatelessWidget {
  const TasksList(
      {super.key, required this.tasksList, required this.noListText});
  final List<Map<String, dynamic>> tasksList;
  final String noListText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPaddings.appPadding,
      child: ListView.builder(
        itemCount: tasksList.length,
        itemBuilder: (BuildContext context, int index) {
          if (tasksList.isEmpty) {
            return Center(
              child: Text(
                noListText,
                style: AppTexts.headingStyle,
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: TaskTile(task: tasksList[index]),
          );
        },
      ),
    );
  }
}

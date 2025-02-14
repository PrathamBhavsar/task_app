import 'package:flutter/material.dart';
import '../../../../../../core/constants/app_consts.dart';
import 'task_tile.dart';

class TasksList extends StatelessWidget {
  const TasksList(
      {super.key,
      required this.tasksList,
      required this.noListText,
      required this.isSalesperson});
  final List<Map<String, dynamic>> tasksList;
  final String noListText;
  final bool isSalesperson;
  @override
  Widget build(BuildContext context) => Padding(
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
              child: TaskTile(
                  task: tasksList[index], isSalesperson: isSalesperson),
            );
          },
        ),
      );
}

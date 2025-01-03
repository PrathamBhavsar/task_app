import 'package:flutter/material.dart';
import 'package:task_app/constants/app_colors.dart';
import 'package:task_app/views/task/widgets/task_tile.dart';
import 'package:task_app/views/home/pages/task%20list/widgets/overlapping_circles.dart';
import 'package:task_app/widgets/circle_icons.dart';

class CompleteTasksList extends StatelessWidget {
  const CompleteTasksList({super.key, required this.completedTasksList});
  final List<Map<String, dynamic>> completedTasksList;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPaddings.appPadding,
      child: ListView.builder(
        itemCount: completedTasksList.length,
        itemBuilder: (BuildContext context, int index) {
          if (completedTasksList.isEmpty) {
            return Center(
              child: Text('No Tasks Completed'),
            );
          }
          return Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: TaskTile(
              task: completedTasksList[index],
            ),
          );
        },
      ),
    );
  }
}

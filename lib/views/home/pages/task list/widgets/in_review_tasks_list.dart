import 'package:flutter/material.dart';
import 'package:task_app/constants/app_colors.dart';
import 'package:task_app/views/home/pages/task%20list/widgets/complete_tasks/widgets/complete_task_tile.dart';

class SharedTasksList extends StatelessWidget {
  const SharedTasksList({super.key, required this.sharedTasksList});
  final List<Map<String, dynamic>> sharedTasksList;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPaddings.appPadding,
      child: ListView.builder(
        itemCount: sharedTasksList.length,
        itemBuilder: (BuildContext context, int index) {
          if (sharedTasksList.isEmpty) {
            return Center(
              child: Text('No Tasks Shared'),
            );
          }
          return Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: TaskTile(
              tasks: sharedTasksList[index],
            ),
          );
        },
      ),
    );
  }
}

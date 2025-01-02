import 'package:flutter/material.dart';
import 'package:task_app/constants/app_colors.dart';
import 'package:task_app/views/home/pages/task%20list/widgets/complete_tasks/widgets/complete_task_tile.dart';

class PendingTasksList extends StatelessWidget {
  const PendingTasksList({super.key, required this.pendingTasksList});
  final List<Map<String, dynamic>> pendingTasksList;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPaddings.appPadding,
      child: ListView.builder(
        itemCount: pendingTasksList.length,
        itemBuilder: (BuildContext context, int index) {
          if (pendingTasksList.isEmpty) {
            return Center(
              child: Text('No Pending Tasks'),
            );
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: TaskTile(tasks: pendingTasksList[index]),
          );
        },
      ),
    );
  }
}

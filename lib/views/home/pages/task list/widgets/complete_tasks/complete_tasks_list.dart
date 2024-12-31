import 'package:flutter/material.dart';
import 'package:task_app/constants/app_colors.dart';
import 'package:task_app/views/home/pages/task%20list/widgets/complete_tasks/widgets/complete_task_tile.dart';
import 'package:task_app/views/home/pages/task%20list/widgets/overlapping_circles.dart';
import 'package:task_app/widgets/circle_icons.dart';

class CompleteTasksList extends StatelessWidget {
  const CompleteTasksList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPaddings.appPadding,
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: TaskTile(),
          );
        },
      ),
    );
  }
}

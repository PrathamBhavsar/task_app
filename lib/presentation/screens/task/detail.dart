import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/extensions/app_paddings.dart';
import '../../providers/task_provider.dart';

class DetailScreen extends StatefulWidget {
  final String taskId;

  const DetailScreen({super.key, required this.taskId});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await Provider.of<TaskProvider>(context, listen: false)
          .fetchTask(widget.taskId);
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('Edit Task')),
        body: Consumer<TaskProvider>(
          builder:
              (BuildContext context, TaskProvider provider, Widget? child) =>
                  Column(
            children: [
              Text(provider.selectedTask.dealNo),
              Text(provider.selectedTask.name),
              Text(provider.selectedTask.remarks ?? ""),
              Text(provider.selectedTask.startDate),
              Text(provider.selectedTask.dueDate),
              Text(provider.selectedTask.createdBy),
            ],
          ).padAll(16),
        ),
      );
}

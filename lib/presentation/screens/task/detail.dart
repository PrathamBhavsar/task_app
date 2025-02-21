import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/models/taskWithUser.dart';
import '../../providers/task_provider.dart';

class DetailScreen extends StatefulWidget {
  final String taskId;

  const DetailScreen({super.key, required this.taskId});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late List<TaskWithUsers> filteredTasks;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await Provider.of<TaskProvider>(context, listen: false)
          .fetchTask(widget.taskId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);
    final selectedTask = provider.selectedTask;

    // Filter tasks where taskId matches selectedTask.id
    filteredTasks = provider.allTasksOverall
        .where((task) => task.taskId == selectedTask?.id)
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text('Edit Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(selectedTask?.name ?? ""),
            Text(selectedTask?.remarks ?? ""),
            Text(selectedTask?.startDate ?? ""),
            Text(selectedTask?.dueDate ?? ""),
            Text(selectedTask?.createdBy ?? ""),
            const SizedBox(height: 16),
            const Text(
              "Related Tasks",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: filteredTasks.length,
                itemBuilder: (context, index) {
                  final task = filteredTasks[index];
                  return Card(
                    child: ListTile(
                      title: Text(task.salespersonName),
                      subtitle: Text(task.agencyName),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

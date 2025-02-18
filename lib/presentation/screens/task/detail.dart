import 'package:flutter/material.dart';

import '../../../data/models/task.dart';

class DetailScreen extends StatelessWidget {
  final Task task;

  const DetailScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(task.name)),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(task.id),
              Text(task.name), // Display other task details
              // Add more UI to show task details
            ],
          ),
        ),
      );
}

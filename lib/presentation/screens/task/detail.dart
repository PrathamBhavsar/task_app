import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String taskId;

  const DetailScreen({super.key, required this.taskId});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(taskId)),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(taskId),
            ],
          ),
        ),
      );
}

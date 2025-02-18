import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../data/models/task.dart';
import '../../../providers/task_provider.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: provider.fetchTasks,
            child: Text('fetch'),
          ),
        ],
      ),
      body: provider.isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: provider.tasks.length,
                    itemBuilder: (context, index) {
                      final Task priority = provider.tasks[index];
                      return ListTile(
                        subtitle: Text(priority.name),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}

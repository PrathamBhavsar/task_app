import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../data/models/task.dart';
import '../../../providers/task_provider.dart';
import 'widgets/task_tileee.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: provider.fetchDashboardDetails,
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
                    itemCount: provider.allTasks.length,
                    itemBuilder: (context, index) {
                      final Task task = provider.allTasks[index];
                      return TaskTile1(task: task);
                    },
                  ),
                ],
              ),
            ),
    );
  }
}

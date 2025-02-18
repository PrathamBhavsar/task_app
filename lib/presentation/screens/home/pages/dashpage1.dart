import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../data/models/dashboard_detail.dart';
import '../../../../data/models/task.dart';
import '../../../providers/task_provider.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

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
                    itemCount: provider.dashboardDetails.length,
                    itemBuilder: (context, index) {
                      final DashboardStatus detail =
                          provider.dashboardDetails[index];
                      return ListTile(
                        title: Text(detail.statusName),
                        subtitle: Text(detail.taskCount.toString()),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}

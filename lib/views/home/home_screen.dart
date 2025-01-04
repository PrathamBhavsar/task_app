import 'package:flutter/material.dart';
import 'package:task_app/providers/task_provider.dart';
import 'package:task_app/views/home/pages/dashboard/dashboard_page.dart';
import 'package:task_app/views/home/pages/task%20list/task_list_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> pages = [const DashboardPage(), const TaskListPage()];

  final pageController = PageController(initialPage: 1);
  @override
  void initState() {
    TaskProvider.instance.fetchAllData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      itemCount: pages.length,
      itemBuilder: (context, index) {
        return pages[index];
      },
    );
  }
}

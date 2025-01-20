import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_app/constants/app_colors.dart';
import 'package:task_app/providers/task_provider.dart';
import 'package:task_app/views/home/pages/dashboard/dashboard_page.dart';
import 'package:task_app/views/home/pages/task%20list/task_list_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> pageTitles = ['Dashboard', 'Task List'];
  List<Widget> pages = [const DashboardPage(), const TaskListPage()];

  final PageController pageController = PageController(initialPage: 0);
  int _currentPageIndex = 0;

  @override
  void initState() {
    // TaskProvider.instance.fetchAllData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/taskDetails?isNewTask=true'),
      ),
      appBar: AppBar(
        title: Text(
          pageTitles[_currentPageIndex],
          style: AppTexts.appBarStyle,
        ),
      ),
      body: PageView.builder(
        controller: pageController,
        itemCount: pages.length,
        onPageChanged: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return pages[index];
        },
      ),
    );
  }
}

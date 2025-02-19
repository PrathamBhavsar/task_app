import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/constants/app_consts.dart';
import '../../providers/home_provider.dart';
import '../../providers/task_provider.dart';
import 'pages/task list/task_list_page.dart';
import 'pages/dashboard/dashboard_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> pageTitles = ['Dashboard', 'Task List'];
  List<Widget> pages = [
    const DashboardPage(),
    const TaskListPage(),
  ];

  final PageController pageController = PageController(initialPage: 0);
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Consumer<HomeProvider>(
        builder: (BuildContext context, HomeProvider provider, Widget? child) =>
            Scaffold(
          floatingActionButton: FloatingActionButton(
            // onPressed: () => _currentPageIndex == 0
            onPressed: () => Provider.of<TaskProvider>(context, listen: false)
                .fetchDashboardDetails(),
            // : context.push('/taskDetails?isNewTask=true'),
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
            itemBuilder: (context, index) => pages[index],
          ),
        ),
      );
}

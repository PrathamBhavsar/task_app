import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_consts.dart';
import '../../providers/home_provider.dart';
import 'pages/dashpage1.dart';
import 'pages/listpage2.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> pageTitles = ['Dashboard', 'Task List'];
  List<Widget> pages = [const Page1(), const Page2()];

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
            onPressed: () => _currentPageIndex == 0
                ? provider.fetchAllData()
                : context.push('/taskDetails?isNewTask=true'),
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

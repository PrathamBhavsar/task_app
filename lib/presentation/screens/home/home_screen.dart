import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants/app_constants.dart';
import '../../../utils/extensions/padding.dart';
import '../../providers/home_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Consumer<HomeProvider>(
    builder:
        (context, provider, child) => Scaffold(
          appBar: AppBar(
            title: Text(provider.title, style: AppTexts.titleTextStyle),
            forceMaterialTransparency: true,
          ),
          bottomNavigationBar: SizedBox(
            height: 60.h,
            child: BottomNavigationBar(
              elevation: 0,
              showUnselectedLabels: true,
              selectedItemColor: Colors.black,
              unselectedItemColor: AppColors.accent,
              selectedLabelStyle: TextStyle(color: Colors.black),
              unselectedLabelStyle: TextStyle(color: AppColors.secondary),
              currentIndex: provider.currentBarIndex,
              onTap: (i) => provider.setBarIndex(i),
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled),
                  label: 'Home',
                  backgroundColor: Colors.white,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.task_alt_rounded),
                  label: 'Task',
                  backgroundColor: Colors.white,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.people),
                  label: 'Customers',
                  backgroundColor: Colors.white,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.collections_bookmark_rounded),
                  label: 'Agencies',
                  backgroundColor: Colors.white,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.monetization_on),
                  label: 'Bills',
                  backgroundColor: Colors.white,
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: provider.currentPage,
          ).padAll(AppPaddings.appPaddingInt),
        ),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants/app_constants.dart';
import '../../../utils/constants/custom_icons.dart';
import '../../../utils/extensions/padding.dart';
import '../../providers/home_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Consumer<HomeProvider>(
    builder:
        (context, provider, child) => Scaffold(
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
                  icon: Icon(CustomIcon.layout),
                  label: 'Home',
                  backgroundColor: Colors.white,
                ),
                BottomNavigationBarItem(
                  icon: Icon(CustomIcon.clipboardList),
                  label: 'Task',
                  backgroundColor: Colors.white,
                ),
                BottomNavigationBarItem(
                  icon: Icon(CustomIcon.users),
                  label: 'Customers',
                  backgroundColor: Colors.white,
                ),
                BottomNavigationBarItem(
                  icon: Icon(CustomIcon.package),
                  label: 'Agencies',
                  backgroundColor: Colors.white,
                ),
                BottomNavigationBarItem(
                  icon: Icon(CustomIcon.receiptIndianRupee),
                  label: 'Bills',
                  backgroundColor: Colors.white,
                ),
              ],
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: provider.currentPage,
            ).padAll(AppPaddings.appPaddingInt),
          ),
        ),
  );
}

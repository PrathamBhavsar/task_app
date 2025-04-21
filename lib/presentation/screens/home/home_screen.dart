import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants/app_constants.dart';
import '../../../utils/constants/custom_icons.dart';
import '../../../utils/enums/user_role.dart';
import '../../../utils/extensions/padding.dart';
import '../../providers/home_provider.dart';
import '../../widgets/selection_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Consumer<HomeProvider>(
    builder: (context, provider, child) {
      final bool isAdmin = provider.currentUserRole == UserRole.admin;
      final bool isSales = provider.currentUserRole == UserRole.salesperson;
      return Scaffold(
        drawer: const SelectionDrawer(),
        appBar:
            provider.currentBarIndex == 0
                ? AppBar(
                  title: Text("Dashboard", style: AppTexts.titleTextStyle),
                  forceMaterialTransparency: true,
                )
                : null,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 0,
          showUnselectedLabels: true,
          selectedItemColor: Colors.black,
          unselectedItemColor: AppColors.accent,
          selectedLabelStyle: TextStyle(color: Colors.black),
          unselectedLabelStyle: TextStyle(color: AppColors.secondary),
          currentIndex: provider.currentBarIndex,
          onTap: (i) => provider.setBarIndex(i),
          items: [
            if (isAdmin)
              BottomNavigationBarItem(
                icon: Icon(CustomIcon.layout),
                label: 'Dashboard',
                backgroundColor: Colors.white,
              ),
            BottomNavigationBarItem(
              icon: Icon(CustomIcon.clipboardList),
              label: isAdmin ? 'Tasks' : 'My Tasks',
              backgroundColor: Colors.white,
            ),
            if (isSales)
              BottomNavigationBarItem(
                icon: Icon(Icons.qr_code),
                label: 'Quotes',
                backgroundColor: Colors.white,
              ),
            BottomNavigationBarItem(
              icon: Icon(CustomIcon.users),
              label: 'Customers',
              backgroundColor: Colors.white,
            ),
            if (isAdmin)
              BottomNavigationBarItem(
                icon: Icon(CustomIcon.package),
                label: 'Agencies',
                backgroundColor: Colors.white,
              ),
            BottomNavigationBarItem(
              icon: Icon(CustomIcon.receiptIndianRupee),
              label: isAdmin ? 'Bills' : 'My Bills',
              backgroundColor: Colors.white,
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: provider.currentPage,
          ).padAll(AppPaddings.appPaddingInt),
        ),
      );
    },
  );
}

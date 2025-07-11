import 'package:flutter/cupertino.dart';

import '../../utils/constants/app_constants.dart';
import '../../utils/constants/custom_icons.dart';
import '../../utils/enums/user_role.dart';

class MenuPage {
  final String name;
  final String title;

  const MenuPage({required this.name, required this.title});

  static final List<MenuPage> pages = [
    MenuPage(name: AppRoutes.serviceMaster, title: 'Dashboard'),
    MenuPage(name: AppRoutes.home, title: 'Home'),
  ];
}

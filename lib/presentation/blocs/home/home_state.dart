import 'package:flutter/material.dart';

import '../../../utils/enums/user_role.dart';
import '../../screens/agency/agency_page.dart';
import '../../screens/bill/bill_page.dart';
import '../../screens/customer/customer_page.dart';
import '../../screens/home/pages/admin_home_page.dart';
import '../../screens/task/task_page.dart';

@immutable
class HomeState {
  final UserRole userRole;
  final int barIndex;

  const HomeState({required this.userRole, required this.barIndex});

  List<String> get titles => [
    "Dashboard",
    "Tasks",
    "Customers",
    "Agencies",
    "Bills",
  ];

  List<Widget> get pages => [
    if (userRole == UserRole.admin) const AdminHomePage(),
    const TaskPage(),
    const TaskPage(),
    const ClientPage(),
    if (userRole == UserRole.admin) const AgencyPage(),
    const BillPage(),
  ];

  Widget get currentPage => pages[barIndex];

  String get currentTitle => titles[barIndex];

  HomeState copyWith({UserRole? userRole, int? barIndex}) {
    return HomeState(
      userRole: userRole ?? this.userRole,
      barIndex: barIndex ?? this.barIndex,
    );
  }
}

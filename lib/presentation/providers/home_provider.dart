import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/enums/user_role.dart';
import '../screens/appointment/appointment_screen.dart';
import '../screens/employee/employee_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/home/manager/manager_home_page.dart';
import '../screens/home/owner/owner_home_page.dart';
import '../screens/managers/manager_screen.dart';
import '../screens/products/product_screen.dart';
import '../screens/reports/report_page.dart';
import '../screens/salons/salon_screen.dart';
import '../screens/services/service_screen.dart';
import '../screens/supervisors/supervisor_screen.dart';
import '../screens/transactions/transactions_screen.dart';

class HomeProvider extends ChangeNotifier {
  UserRole _currentUserRole = UserRole.owner;

  HomeProvider() {
    _loadUserRole();
  }

  UserRole get currentUserRole => _currentUserRole;

  Future<void> setUserRole(UserRole role) async {
    _currentUserRole = role;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userRole', role.toString());
  }

  Future<void> _loadUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    final roleString = prefs.getString('userRole');

    if (roleString != null) {
      _currentUserRole = UserRole.values.firstWhere(
        (e) => e.toString() == roleString,
        orElse: () => UserRole.owner,
      );
    } else {
      _currentUserRole = UserRole.owner;
    }

    notifyListeners();
  }

  /// The first page depends on the user role
  Widget get firstPage =>
      _currentUserRole == UserRole.owner ? OwnerHomePage() : ManagerHomePage();

  List<String> get menuPageNames => [
    'home',
    'appointment',
    'transaction',
    'employee',
    'service',
    'product',
    'report',
    'salon',
    'supervisor',
    'manager',
  ];

  /// Titles for AppBar
  List<String> get titles => [
    "Dashboard",
    "Appointments",
    "Transactions",
    "Employees",
    "Services",
    "Products",
    "Reports",
    "Salon Management",
    "Supervisors",
    "Managers",
  ];
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/enums/user_role.dart';
import '../screens/agency/agency_page.dart';
import '../screens/bill/bill_page.dart';
import '../screens/customer/customer_page.dart';
import '../screens/home/pages/admin_home_page.dart';
import '../screens/quote/quote_page.dart';
import '../screens/task/task_page.dart';

class HomeProvider extends ChangeNotifier {
  UserRole _currentUserRole = UserRole.salesperson;

  HomeProvider() {
    // _loadUserRole();
  }

  bool _isActive = true;

  bool get isActive => _isActive;

  void toggleActive() {
    _isActive = !_isActive;
    notifyListeners();
  }

  void setActive(value) {
    _isActive = value;
    notifyListeners();
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
        orElse: () => UserRole.admin,
      );
    } else {
      _currentUserRole = UserRole.admin;
    }

    notifyListeners();
  }

  Widget get firstPage =>
      _currentUserRole == UserRole.admin ? AdminHomePage() : AdminHomePage();

  List<Widget> get pages => [
    if (currentUserRole == UserRole.admin) firstPage,
    TaskPage(),
    if (currentUserRole == UserRole.salesperson) QuotePage(),
    CustomerPage(),
    if (currentUserRole == UserRole.admin) AgencyPage(),
    BillPage(),
  ];

  /// Titles for AppBar
  List<String> get titles => [
    "Dashboard",
    "Tasks",
    "Customers",
    "Agencies",
    "Bills",
  ];

  Widget get currentPage => pages[_currentBarIndex];

  String get title => titles[_currentBarIndex];

  int _currentBarIndex = 0;

  int get currentBarIndex => _currentBarIndex;

  setBarIndex(int value) {
    _currentBarIndex = value;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:task_app/constants/enums.dart';

class AuthProvider extends ChangeNotifier {
  static final AuthProvider instance = AuthProvider._privateConstructor();

  AuthProvider._privateConstructor();
  var logger = Logger();

  bool isVisible = false;
  UserRoles currentUserRole = UserRoles.salesperson;

  /// Toggle visibility
  void toggleVisibility() {
    isVisible = !isVisible;
    notifyListeners();
  }

  /// Toggle user roles
  void toggleUserRole(UserRoles userRole) {
    currentUserRole = userRole;
    notifyListeners();
  }
}

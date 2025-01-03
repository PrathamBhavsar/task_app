import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:task_app/constants/enums.dart';
import 'package:task_app/controllers/supabase_controller.dart';

class AuthProvider extends ChangeNotifier {
  static final AuthProvider instance = AuthProvider._privateConstructor();

  AuthProvider._privateConstructor();
  var logger = Logger();

  bool isVisible = false;
  UserRole currentUserRole = UserRole.salesperson;

  /// Toggle visibility
  void toggleVisibility() {
    isVisible = !isVisible;
    notifyListeners();
  }

  /// Toggle user roles
  void toggleUserRole(UserRole userRole) {
    currentUserRole = userRole;
    notifyListeners();
  }
}

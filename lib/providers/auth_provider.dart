import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../constants/enums.dart';
import '../models/user.dart';

class AuthProvider extends ChangeNotifier {
  static final AuthProvider instance = AuthProvider._privateConstructor();

  AuthProvider._privateConstructor();
  var logger = Logger();

  bool isVisible = false;
  UserRole currentUserRole = UserRole.salesperson;
  UserModel? currentUser;

  /// Sets currentUser
  void setCurrentUser(user) {
    currentUser = user;
    notifyListeners();
  }

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
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../../core/constants/enums/user_role.dart';
import '../../old/models/user.dart';

class AuthProvider extends ChangeNotifier {
  static final AuthProvider _instance = AuthProvider._privateConstructor();

  AuthProvider._privateConstructor();

  static AuthProvider get instance => _instance;

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

import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isVisible = false;

  bool get isVisible => _isVisible;

  void toggleVisibility() {
    _isVisible = !_isVisible;
    notifyListeners();
  }

  String _selectedRole = 'Admin';

  String get selectedRole => _selectedRole;

  void setRole(String role) {
    _selectedRole = role;
    notifyListeners();
  }
}

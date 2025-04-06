import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isVisible = false;

  bool get isVisible => _isVisible;

  void toggleVisibility() {
    _isVisible = !_isVisible;
    notifyListeners();
  }

  int _otpIndex = 0;
  int get otpIndex => _otpIndex;

  void setOtpIndex(int value) {
    _otpIndex = value;
    notifyListeners();
  }


  String _selectedRole = 'Admin';

  String get selectedRole => _selectedRole;

  void setRole(String role) {
    _selectedRole = role;
    notifyListeners();
  }
}

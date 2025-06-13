import 'package:flutter/material.dart';

class SnackBarHelper {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey;

  SnackBarHelper(this.scaffoldMessengerKey);

  void showError(String message) {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade300,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void showSuccess(String message) {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green.shade300,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

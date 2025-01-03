import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class NotificationProvider extends ChangeNotifier {
  static final NotificationProvider instance =
      NotificationProvider._privateConstructor();

  NotificationProvider._privateConstructor();

  final Logger log = Logger();
  List<Map<String, dynamic>> allNotifications = [];
}

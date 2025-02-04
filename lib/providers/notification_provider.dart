import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class NotificationProvider extends ChangeNotifier {
  static final NotificationProvider _instance =
      NotificationProvider._privateConstructor();

  NotificationProvider._privateConstructor();

  static NotificationProvider get instance => _instance;

  final Logger log = Logger();
  List<Map<String, dynamic>> allNotifications = [];
}

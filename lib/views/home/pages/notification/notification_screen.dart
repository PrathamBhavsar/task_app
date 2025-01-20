import 'package:flutter/material.dart';
import 'package:task_app/constants/app_colors.dart';
import 'package:task_app/views/home/pages/notification/widgets/notificationList.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          'Notifications',
          style: AppTexts.appBarStyle,
        ),
      ),
      body: Padding(
        padding: AppPaddings.appPadding,
        child: NotificationList(),
      ),
    );
  }
}

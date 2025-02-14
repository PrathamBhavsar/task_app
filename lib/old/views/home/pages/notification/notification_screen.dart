import 'package:flutter/material.dart';
import '../../../../../core/constants/app_consts.dart';
import 'widgets/notificationList.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
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

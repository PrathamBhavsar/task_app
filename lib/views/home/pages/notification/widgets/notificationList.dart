import 'package:flutter/material.dart';
import 'package:task_app/constants/app_colors.dart';
import 'package:task_app/views/home/pages/notification/widgets/notification_list_tile.dart';

class NotificationList extends StatelessWidget {
  const NotificationList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: NotificationListTile(
            color: AppColors.purple,
            date: '2025-01-05T10:22:17+00:00',
            text: 'task assigned',
          ),
        );
      },
    );
  }
}

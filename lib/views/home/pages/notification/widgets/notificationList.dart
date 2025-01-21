import 'package:flutter/material.dart';
import '../../../../../constants/app_colors.dart';
import 'notification_list_tile.dart';

class NotificationList extends StatelessWidget {
  const NotificationList({super.key});

  @override
  Widget build(BuildContext context) => ListView.builder(
      itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: NotificationListTile(
            color: AppColors.purple,
            date: '2025-01-05T10:22:17+00:00',
            text: 'task assigned',
          ),
        ),
    );
}

import 'package:flutter/material.dart';
import 'package:task_app/constants/app_colors.dart';

class AttachmentsList extends StatelessWidget {
  const AttachmentsList({super.key, required this.attachmentsList});
  final List<Map<String, dynamic>> attachmentsList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: attachmentsList.length,
      itemBuilder: (context, index) {
        final attachment = attachmentsList[index];
        String extension = '';

        if (attachment['attachment_url'] != null) {
          extension = attachment['attachment_url']
              .split('.')
              .last
              .split('?')
              .first
              .toLowerCase();
        }

        Color bgColor = _getColorBasedOnExtension(extension);
        return Container(
          color: bgColor,
          height: 60,
          child: Row(
            children: [
              Text(
                attachment['attachment_name'] ?? 'No name',
                style: AppTexts.headingStyle,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.close_rounded),
              )
            ],
          ),
        );
      },
    );
  }

  Color _getColorBasedOnExtension(String extension) {
    switch (extension) {
      case 'pdf':
        return AppColors.pdfRed;
      case 'jpg':
        return AppColors.jpgBlue;
      default:
        return AppColors.defaultColor;
    }
  }
}

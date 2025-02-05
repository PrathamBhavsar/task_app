import 'package:flutter/material.dart';
import '../../../constants/app_consts.dart';
import '../../../controllers/supabase_controller.dart';

class AttachmentsList extends StatelessWidget {
  const AttachmentsList(
      {super.key, required this.attachmentsList, required this.dealNo});
  final List<Map<String, dynamic>> attachmentsList;
  final String dealNo;

  @override
  Widget build(BuildContext context) => Padding(
        padding: AppPaddings.appPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (attachmentsList.isNotEmpty) ...[
              Text(
                'Attachments',
                style: AppTexts.headingStyle,
              ),
              const SizedBox(height: 10),
            ],
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
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
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: AppBorders.radius,
                    border: Border.all(width: 2),
                  ),
                  height: 60,
                  margin: const EdgeInsets.only(bottom: 8.0),
                  child: Padding(
                    padding: AppPaddings.appPadding,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          attachment['attachment_name'] ?? 'Untitled',
                          style: AppTexts.tileTitle2,
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () async {
                                await SupabaseController.instance
                                    .downloadAttachment(
                                        attachment['attachment_name'], dealNo);
                              },
                              icon: const Icon(Icons.download_rounded),
                            ),
                            const SizedBox(width: 5),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.close_rounded),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      );

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

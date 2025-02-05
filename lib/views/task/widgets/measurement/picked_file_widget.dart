import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../constants/app_colors.dart';
import '../../../../helpers/file_name_helper.dart';

class PickedFileWidget extends StatelessWidget {
  const PickedFileWidget(
      {super.key,
      required this.fileName,
      required this.onCancel,
      required this.isNewTask});

  final String fileName;
  final VoidCallback onCancel;
  final bool isNewTask;

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          borderRadius: AppBorders.radius,
          border: Border.all(width: 2),
        ),
        height: 60.h,
        margin: const EdgeInsets.only(bottom: 8.0),
        child: Padding(
          padding: AppPaddings.appPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                FileNameHelper.trimmedFileName(fileName),
                overflow: TextOverflow.ellipsis,
                style: AppTexts.tileTitle2,
              ),
              Row(
                children: [
                  isNewTask
                      ? IconButton(
                          onPressed: () async {},
                          icon: const Icon(Icons.download_rounded),
                        )
                      : SizedBox.shrink(),
                  AppPaddings.gapW(5),
                  IconButton(
                    onPressed: onCancel,
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              )
            ],
          ),
        ),
      );
}

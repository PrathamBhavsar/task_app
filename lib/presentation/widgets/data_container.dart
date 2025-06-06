import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/constants/app_constants.dart';
import '../../utils/extensions/padding.dart';
import 'bordered_container.dart';

class DataContainer extends StatelessWidget {
  const DataContainer({
    required this.title, super.key,
    this.subtitle,
    this.data,
  });

  final String title;
  final String? data, subtitle;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.zero,
    child: BorderedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTexts.labelTextStyle),
          5.hGap,
          Text(data ?? "0", style: AppTexts.titleTextStyle),
          subtitle == null
              ? SizedBox.shrink()
              : Builder(
                builder: (context) {
                  final match = RegExp(
                    r'([\+\-]?\d+(\.\d+)?%?)',
                  ).firstMatch(subtitle!);
                  final String numberPart = match?.group(0) ?? '';
                  final String remainingText =
                      subtitle!.replaceFirst(numberPart, '').trim();

                  return RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: numberPart,
                          style: AppTexts.inputHintTextStyle.copyWith(
                            fontSize: 12.sp,
                            color:
                                numberPart.startsWith("+")
                                    ? AppColors.green
                                    : AppColors.errorRed,
                          ),
                        ),
                        if (remainingText.isNotEmpty)
                          TextSpan(
                            text: " $remainingText",
                            style: AppTexts.inputHintTextStyle.copyWith(
                              fontSize: 12.sp,
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
        ],
      ),
    ),
  );
}

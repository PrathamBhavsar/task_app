import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/constants/app_constants.dart';
import '../../utils/extensions/padding.dart';
import 'bordered_container.dart';

class DataContainer extends StatelessWidget {
  const DataContainer({
    super.key,
    required this.title,
    required this.subtitle,
    required this.data,
    required this.padding,
  });

  final String title, subtitle;
  final String? data;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) => Padding(
    padding: padding,
    child: BorderedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTexts.labelTextStyle),
          5.hGap,
          Text(data ?? "0", style: AppTexts.titleTextStyle),
          Builder(
            builder: (context) {
              final match = RegExp(
                r'([\+\-]?\d+(\.\d+)?%?)',
              ).firstMatch(subtitle);
              final String numberPart = match?.group(0) ?? '';
              final String remainingText =
                  subtitle.replaceFirst(numberPart, '').trim();

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

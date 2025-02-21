import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../../utils/constants/app_consts.dart';
import '../../../../../utils/extensions/app_paddings.dart';
import '../../../../providers/task_provider.dart';

class AgencyRequiredSwitch extends StatelessWidget {
  const AgencyRequiredSwitch({super.key, required this.isSalesperson});

  final bool isSalesperson;
  @override
  Widget build(BuildContext context) => Visibility(
        visible: isSalesperson,
        child: SizedBox(
          height: 60.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Is Agency Required?',
                style: AppTexts.headingStyle,
              ),
              Consumer<TaskProvider>(
                builder: (BuildContext context, TaskProvider provider,
                        Widget? child) =>
                    Switch(
                  value: provider.isAgencyRequired,
                  inactiveTrackColor: AppColors.accent,
                  onChanged: (value) => provider.toggleAgencyRequired(),
                ),
              )
            ],
          ),
        ).padAll(AppPaddings.appPaddingInt),
      );
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/app_colors.dart';
import '../../../providers/task_provider.dart';

class AgencyRequiredSwitch extends StatelessWidget {
  const AgencyRequiredSwitch({super.key, required this.isSalesperson});

  final bool isSalesperson;
  @override
  Widget build(BuildContext context) => Visibility(
        visible: isSalesperson,
        child: Padding(
          padding: AppPaddings.appPadding,
          child: SizedBox(
            height: 60,
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
          ),
        ),
      );
}

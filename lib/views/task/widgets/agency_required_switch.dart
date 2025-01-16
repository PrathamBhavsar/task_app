import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/constants/app_colors.dart';
import 'package:task_app/providers/task_provider.dart';

class AgencyRequiredSwitch extends StatelessWidget {
  const AgencyRequiredSwitch({super.key, required this.isSalesperson});

  final bool isSalesperson;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isSalesperson,
      child: Padding(
        padding: AppPaddings.appPadding,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Is Agency Required?',
                style: TextStyle(fontSize: 22, fontWeight: AppTexts.fW700),
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
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_app/constants/app_colors.dart';
import 'package:task_app/providers/task_provider.dart';

class DueDatePicker extends StatelessWidget {
  final bool isNewTask;

  DueDatePicker({super.key, required this.isNewTask});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (BuildContext context, TaskProvider provider, Widget? child) {
        return Row(
          children: [
            _buildDatePicker(
              context,
              provider,
              isStartDate: true,
              label: 'Start Date',
              date: isNewTask ? DateTime.now() : provider.startDate,
              onDateSelected: (selectedDate) {
                provider.setStartDate(selectedDate);
              },
            ),
            AppPaddings.gapW(10),
            _buildDatePicker(
              context,
              provider,
              isStartDate: false,
              label: 'Due Date',
              date: isNewTask
                  ? DateTime.now().add(Duration(days: 2))
                  : provider.dueDate,
              onDateSelected: (selectedDate) {
                provider.setDueDate(selectedDate);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildDatePicker(
    BuildContext context,
    TaskProvider provider, {
    required bool isStartDate,
    required String label,
    required DateTime date,
    required void Function(DateTime) onDateSelected,
  }) {
    return Flexible(
      child: GestureDetector(
        onTap: () async {
          DateTime initialDate = date;
          DateTime firstDate = isNewTask ? DateTime.now() : DateTime(2000);
          DateTime lastDate = DateTime(2101);

          DateTime? selectedDate = await showDatePicker(
            context: context,
            initialDate: initialDate,
            firstDate: firstDate,
            lastDate: lastDate,
          );

          if (selectedDate != null) {
            onDateSelected(selectedDate);
          }
        },
        child: Container(
          padding: AppPaddings.appPadding,
          decoration: BoxDecoration(
            border: Border.all(width: 2),
            borderRadius: AppTexts.borderRadius,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 16, fontWeight: AppTexts.fW900),
              ),
              AppPaddings.gapH(10),
              Row(
                children: [
                  Icon(Icons.calendar_month_rounded),
                  AppPaddings.gapW(5),
                  Text(
                    provider.formatDate(date),
                    style: TextStyle(fontSize: 20, fontWeight: AppTexts.fW900),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

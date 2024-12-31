import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_app/providers/task_provider.dart';
import 'package:task_app/widgets/custom_text_feild.dart';

class DueDatePicker extends StatelessWidget {
  final FocusNode dateFocusNode = FocusNode();
  final bool isNewTask;

  DueDatePicker({super.key, required this.isNewTask});

  @override
  Widget build(BuildContext context) {
    final dueDate = isNewTask ? DateTime.now() : TaskProvider.instance.dueDate;

    return GestureDetector(
      onTap: () async {
        DateTime initialDate = dueDate;
        DateTime firstDate = isNewTask ? DateTime.now() : DateTime(2000);
        DateTime lastDate = DateTime(2101);

        DateTime? selectedDate = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: firstDate,
          lastDate: lastDate,
        );

        if (selectedDate != null) {
          TaskProvider.instance.setDueDate(selectedDate);
        }
      },
      child: CustomTextField(
        controller: TextEditingController(text: _formatDate(dueDate)),
        hintTxt: 'Due Date',
        labelTxt: 'Due Date',
        isEnabled: false,
        focusNode: dateFocusNode,
      ),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('d MMM, yyyy').format(date);
  }
}

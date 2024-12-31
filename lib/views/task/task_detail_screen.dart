import 'package:flutter/material.dart';
import 'package:task_app/constants/app_colors.dart';
import 'package:task_app/views/task/widgets/client_name_dropdown.dart';
import 'package:task_app/views/task/widgets/due_date_picker.dart';
import 'package:task_app/views/task/widgets/user_modal.dart';
import 'package:task_app/widgets/custom_picker_feild.dart';
import 'package:task_app/widgets/custom_text_feild.dart';

class TaskDetailScreen extends StatefulWidget {
  const TaskDetailScreen({super.key});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  final nameController = TextEditingController();
  final assigneeController = TextEditingController();
  final nameFocusNode = FocusNode();

  @override
  void dispose() {
    nameController.dispose();
    assigneeController.dispose();
    nameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text(
          'Task Details',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: AppPaddings.appPadding,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: AppColors.green,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Icon(Icons.person_2_rounded),
                  ),
                ),
                AppPaddings.gapW(10),
                ClientNameDropdown(),
              ],
            ),
            AppPaddings.gapH(20),
            CustomTextField(
              controller: nameController,
              focusNode: nameFocusNode,
              labelTxt: 'Task Name',
              hintTxt: 'Task Name',
            ),
            AppPaddings.gapH(20),
            Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: AppColors.orange,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Icon(Icons.calendar_month_rounded),
                  ),
                ),
                AppPaddings.gapW(10),
                Flexible(
                  child: DueDatePicker(
                    isNewTask: false,
                  ),
                )
              ],
            ),
            AppPaddings.gapH(10),
            Divider(
              color: AppColors.primary,
            ),
            AppPaddings.gapH(10),
            Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: AppColors.purple,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Icon(Icons.group_rounded),
                  ),
                ),
                AppPaddings.gapW(10),
                Flexible(
                  child: _buildSelectableField(
                    label: 'Assign To',
                    hint: 'Assign To',
                    controller: assigneeController,
                    tableName: 'task_assignees',
                  ),
                )
              ],
            ),
            AppPaddings.gapH(10),
            Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: AppColors.pink,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Icon(Icons.flag_rounded),
                  ),
                ),
                AppPaddings.gapW(10),
                Flexible(
                  child: CustomTextField(
                    labelTxt: 'Priority',
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectableField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required String tableName,
    FocusNode? focusNode,
    Icon? prefixIcon,
  }) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (_) => UserModal(
            table: tableName,
            title: label,
            textController: controller,
          ),
        );
      },
      child: CustomTextField(
        controller: controller,
        hintTxt: hint,
        labelTxt: label,
        isEnabled: false,
        focusNode: focusNode ?? null,
        prefixIcon: prefixIcon ?? null,
      ),
    );
  }
}

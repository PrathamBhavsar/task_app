import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/constants/app_colors.dart';
import 'package:task_app/providers/task_provider.dart';
import 'package:task_app/views/home/pages/task%20list/widgets/overlapping_circles.dart';
import 'package:task_app/views/task/widgets/agency_required_switch.dart';
import 'package:task_app/views/task/widgets/client_name_dropdown.dart';
import 'package:task_app/views/task/widgets/due_date_picker.dart';
import 'package:task_app/widgets/custom_tag.dart';
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
      body: Consumer<TaskProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: AppPaddings.appPadding,
            child: ListView(
              children: [
                _buildRowWithIconAndWidget(
                  icon: Icons.person_2_rounded,
                  widget: ClientNameDropdown(),
                ),
                AppPaddings.gapH(20),
                CustomTextField(
                  controller: nameController,
                  focusNode: nameFocusNode,
                  labelTxt: 'Task Name',
                  hintTxt: 'Task Name',
                ),
                AppPaddings.gapH(20),
                DueDatePicker(isNewTask: false),
                _buildDivider(),
                AppPaddings.gapH(10), // Added gap for consistent spacing
                _buildRowWithTextAndWidget(
                  label: 'Status',
                  widget: CustomTag(
                    color: AppColors.pink,
                    text: 'Meeting',
                  ),
                ),
                AppPaddings.gapH(10),
                _buildRowWithTextAndWidget(
                  label: 'Assigned For',
                  widget: OverlappingCircles(numberOfCircles: 3),
                ),
                AppPaddings.gapH(10),
                _buildRowWithTextAndWidget(
                  label: 'Priority',
                  widget: CustomTag(
                    color: AppColors.green,
                    text: 'Low',
                  ),
                ),
                _buildDivider(),
                const AgencyRequiredSwitch(),
                if (provider.isAgencyRequired)
                  Column(
                    children: [
                      _buildRowWithTextAndWidget(
                        label: 'Assigned For',
                        widget: OverlappingCircles(numberOfCircles: 3),
                      ),
                      AppPaddings.gapH(10),
                    ],
                  ),
                _buildDivider(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Attachments',
                    style: AppTexts.headingStyle,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildRowWithIconAndWidget({
    required IconData icon,
    required Widget widget,
  }) {
    return Row(
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: AppColors.green,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(icon, size: 32),
        ),
        AppPaddings.gapW(10),
        Expanded(child: widget),
      ],
    );
  }

  Widget _buildRowWithTextAndWidget({
    required String label,
    required Widget widget,
  }) {
    return Container(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTexts.headingStyle,
          ),
          widget,
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Column(
      children: [
        AppPaddings.gapH(10),
        Divider(color: AppColors.primary),
        AppPaddings.gapH(10),
      ],
    );
  }
}

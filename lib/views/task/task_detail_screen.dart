import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/constants/app_colors.dart';
import 'package:task_app/constants/enums.dart';
import 'package:task_app/constants/supabase_keys.dart';
import 'package:task_app/providers/task_provider.dart';
import 'package:task_app/views/home/pages/task%20list/widgets/overlapping_circles.dart';
import 'package:task_app/views/task/methods/show_bottom_modal.dart';
import 'package:task_app/views/task/widgets/agency_required_switch.dart';
import 'package:task_app/views/task/widgets/client_name_dropdown.dart';
import 'package:task_app/views/task/widgets/due_date_picker.dart';
import 'package:task_app/widgets/action_button.dart';
import 'package:task_app/widgets/custom_tag.dart';
import 'package:task_app/widgets/custom_text_feild.dart';

class TaskDetailScreen extends StatefulWidget {
  final bool isNewTask;
  final String dealNo;

  const TaskDetailScreen({
    Key? key,
    required this.isNewTask,
    required this.dealNo,
  }) : super(key: key);

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  final nameController = TextEditingController(
      text: TaskProvider.instance.fetchedTaskData['name'] ?? "");
  final remarkController = TextEditingController(
      text: TaskProvider.instance.fetchedTaskData['name'] ?? "");
  final assigneeController = TextEditingController();
  final nameFocusNode = FocusNode();
  final remarkFocusNode = FocusNode();

  @override
  void initState() {
    if (!widget.isNewTask) {
      TaskProvider.instance.getTaskByDealNo(widget.dealNo);
    }
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    remarkController.dispose();
    assigneeController.dispose();
    nameFocusNode.dispose();
    remarkFocusNode.dispose();
    TaskProvider.instance.resetTaskIndexes();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          title: const Text(
            'Task Details',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
        body: Consumer<TaskProvider>(
          builder: (context, provider, child) {
            final data = provider.fetchedData;

            return Padding(
              padding: AppPaddings.appPadding,
              child: ListView(children: [
                _buildRowWithIconAndWidget(
                  icon: Icons.person_2_rounded,
                  widget: _dropdownWidget(
                    context: context,
                    dataList: data['clients'],
                    title: 'Clients',
                    index: provider.selectedIndices['client'],
                    name: 'name',
                    field: 'client',
                    defaultText: "No Clients Yet",
                  ),
                ),
                AppPaddings.gapH(20),
                CustomTextField(
                  controller: nameController,
                  focusNode: nameFocusNode,
                  labelTxt: 'Task Name',
                  hintTxt: 'Task Name',
                ),
                AppPaddings.gapH(20),
                CustomTextField(
                  controller: remarkController,
                  focusNode: remarkFocusNode,
                  labelTxt: 'Remarks',
                  hintTxt: 'Remarks',
                ),
                AppPaddings.gapH(20),
                DueDatePicker(isNewTask: false),
                _buildDivider(),
                _buildDynamicRow(
                  context: context,
                  label: 'Status',
                  dataList: data[SupabaseKeys.taskStatusTable],
                  widget: CustomTag(
                      color: provider.stringToColor(
                          data[SupabaseKeys.taskStatusTable]
                              ?[provider.selectedIndices['status']]['color']),
                      text: data[SupabaseKeys.taskStatusTable]
                              ?[provider.selectedIndices['status']]['name'] ??
                          ""),
                  field: 'status',
                ),
                _buildDynamicRow(
                  context: context,
                  label: 'Assigned For',
                  dataList: data['salespersons'],
                  widget: const OverlappingCircles(numberOfCircles: 3),
                  field: 'salespersons',
                ),
                _buildDynamicRow(
                  context: context,
                  label: 'Designers',
                  dataList: data['designers'],
                  widget: const OverlappingCircles(numberOfCircles: 3),
                  field: 'designers',
                ),
                _buildDynamicRow(
                  context: context,
                  label: 'Priority',
                  dataList: data[SupabaseKeys.taskPriorityTable],
                  widget: CustomTag(
                      color: provider.stringToColor(
                          data[SupabaseKeys.taskPriorityTable]
                              ?[provider.selectedIndices['priority']]['color']),
                      text: data[SupabaseKeys.taskPriorityTable]
                              ?[provider.selectedIndices['priority']]['name'] ??
                          ""),
                  field: 'priority',
                ),
                _buildDivider(),
                const AgencyRequiredSwitch(),
                if (provider.isAgencyRequired)
                  _buildDynamicRow(
                    context: context,
                    label: UserRole.agency.role,
                    dataList: data['agencies'],
                    widget: const OverlappingCircles(numberOfCircles: 3),
                    field: 'agency',
                  ),
                //   if (data['task_attachments'] != null &&
                //       data['task_attachments']!.isNotEmpty)
                //     _buildDynamicRow(
                //       context: context,
                //       label: 'Attachments',
                //       dataList: data['task_attachments'],
                //       widget: SizedBox.shrink(),
                //       field: 'attachment',
                //     ),
                //   AttachmentsList(
                //       attachmentsList: data['task_attachments'] ?? []),
              ]),
            );
          },
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
          child: ActionBtn(
            btnTxt: widget.isNewTask ? 'Create Task' : 'Edit Task',
            onPress: () async {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(width: 2),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.isNewTask ? 'Create Task?' : 'Edit Task?',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: AppTexts.fW700,
                          ),
                        ),
                        AppPaddings.gapH(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ActionBtn(
                                btnTxt: 'Cancel',
                                onPress: () => Navigator.of(context).pop(),
                                fontColor: AppColors.primary,
                                backgroundColor: AppColors.pink,
                              ),
                            ),
                            AppPaddings.gapW(10),
                            Expanded(
                              child: ActionBtn(
                                btnTxt: widget.isNewTask ? 'Create' : 'Edit',
                                onPress: () {
                                  Navigator.of(context).pop();
                                },
                                fontColor: AppColors.primary,
                                backgroundColor: AppColors.green,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
              ;
              ;
            },
            fontColor: AppColors.primary,
            backgroundColor: AppColors.orange,
          ),
        ),
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

  Widget _buildDynamicRow({
    required BuildContext context,
    required String label,
    required String field,
    required List<Map<String, dynamic>>? dataList,
    required Widget widget,
  }) {
    return Padding(
      padding: AppPaddings.appPadding,
      child: _buildRowWithTextAndWidget(
        label: label,
        widget: widget,
        onTap: () =>
            showClientsBottomSheet(context, dataList ?? [], label, field),
      ),
    );
  }

  Widget _dropdownWidget({
    required BuildContext context,
    required List<Map<String, dynamic>>? dataList,
    required int index,
    required String title,
    required String name,
    required String field,
    required String defaultText,
  }) {
    return ClientNameDropdown(
      name: dataList?.isNotEmpty == true ? dataList![index][name] : defaultText,
      clientList: dataList ?? [],
      onTap: () =>
          showClientsBottomSheet(context, dataList ?? [], title, field),
    );
  }

  Widget _buildRowWithTextAndWidget({
    required String label,
    required Widget widget,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: AppTexts.headingStyle),
            widget,
          ],
        ),
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

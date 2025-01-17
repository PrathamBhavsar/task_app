import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/constants/app_colors.dart';
import 'package:task_app/constants/enums.dart';
import 'package:task_app/constants/app_keys.dart';
import 'package:task_app/providers/task_provider.dart';
import 'package:task_app/views/home/pages/task%20list/widgets/overlapping_circles.dart';
import 'package:task_app/views/task/methods/show_bottom_modal.dart';
import 'package:task_app/views/task/widgets/agency_required_switch.dart';
import 'package:task_app/views/task/widgets/client_name_dropdown.dart';
import 'package:task_app/views/task/widgets/due_date_picker.dart';
import 'package:task_app/views/task/widgets/measurement/measurement_widget.dart';
import 'package:task_app/widgets/action_button.dart';
import 'package:task_app/widgets/custom_tag.dart';
import 'package:task_app/widgets/custom_text_feild.dart';

class TaskDetailScreen extends StatefulWidget {
  final bool isSalesperson;
  final bool isNewTask;
  final String dealNo;

  const TaskDetailScreen({
    Key? key,
    required this.isSalesperson,
    required this.isNewTask,
    required this.dealNo,
  }) : super(key: key);

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  final nameController = TextEditingController();
  final remarkController = TextEditingController();

  final nameFocusNode = FocusNode();
  final remarkFocusNode = FocusNode();

  @override
  void initState() {
    if (!widget.isNewTask) {
      TaskProvider.instance.getTaskByDealNo(widget.dealNo).then((_) {
        setState(() {
          nameController.text =
              TaskProvider.instance.fetchedTaskData['name'] ?? '';
          remarkController.text =
              TaskProvider.instance.fetchedTaskData['remarks'] ?? '';
        });
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    remarkController.dispose();
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
        resizeToAvoidBottomInset: false,
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
                    index: provider.selectedIndices[IndexKeys.clientIndex],
                    name: 'name',
                    indexKey: 'client',
                    defaultText: "No Clients Yet",
                    isNewTask: widget.isNewTask,
                    dealNo: widget.dealNo,
                  ),
                ),
                AppPaddings.gapH(20),

                CustomTextField(
                  controller: TextEditingController(
                      text:
                          ' This is a demo address textThis is a demo address textThis is a demo address textThis is a demo address text'),
                  isEnabled: false,
                  labelTxt: 'Address',
                  keyboardType: TextInputType.multiline,
                  isMultiline: true,
                ),
                AppPaddings.gapH(20),

                CustomTextField(
                  controller: TextEditingController(text: '8490088688'),
                  isEnabled: false,
                  labelTxt: 'Contact Information',
                  isPhone: true,
                ),
                _buildDivider(verticalPadding: 10),
                AppPaddings.gapH(10),

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
                  isMultiline: true,
                ),
                AppPaddings.gapH(20),
                DatePickerWidget(isNewTask: false),
                AppPaddings.gapH(10),
                _buildDivider(),
                _buildDynamicRow(
                  context: context,
                  label: 'Status',
                  dataList: data[SupabaseKeys.taskStatusTable],
                  widget: CustomTag(
                      color: provider.stringToColor(data[
                                  SupabaseKeys.taskStatusTable]
                              ?[provider.selectedIndices[IndexKeys.statusIndex]]
                          [AppKeys.color]),
                      text: data[SupabaseKeys.taskStatusTable]?[provider
                                  .selectedIndices[IndexKeys.statusIndex]]
                              [AppKeys.name] ??
                          ""),
                  indexKey: IndexKeys.statusIndex,
                  isSalesperson: true,
                ),
                _buildDynamicRow(
                  context: context,
                  label: 'Assigned For',
                  dataList: data[AppKeys.fetchedSalespersons],
                  widget: OverlappingCircles(
                    bgColors: (data[AppKeys.fetchedSalespersons] ?? [])
                        .map(
                          (user) => provider.stringToColor(
                            user[UserDetails.profileBgColor],
                          ),
                        )
                        .toList(),
                    displayNames: (data[AppKeys.fetchedSalespersons] ?? [])
                        .map((user) => user[UserDetails.name] as String)
                        .toList(),
                  ),
                  indexKey: IndexKeys.salespersonIndex,
                  isSalesperson: widget.isSalesperson,
                ),
                _buildDynamicRow(
                  context: context,
                  label: 'Designers',
                  dataList: data[AppKeys.fetchedDesigners],
                  widget: provider
                          .selectedIndices[IndexKeys.designerIndex]!.isNotEmpty
                      ? OverlappingCircles(
                          bgColors: (data[AppKeys.fetchedDesigners] ?? [])
                              .map(
                                (user) => provider.stringToColor(
                                  user[UserDetails.profileBgColor],
                                ),
                              )
                              .toList(),
                          displayNames: (data[AppKeys.fetchedDesigners] ?? [])
                              .map((user) => user[UserDetails.name] as String)
                              .toList(),
                        )
                      : Text(
                          'None',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: AppTexts.fW700,
                          ),
                        ),
                  indexKey: IndexKeys.designerIndex,
                  isSalesperson: widget.isSalesperson,
                ),
                _buildDynamicRow(
                  context: context,
                  label: 'Priority',
                  dataList: data[SupabaseKeys.taskPriorityTable],
                  widget: CustomTag(
                      color: provider.stringToColor(
                          data[SupabaseKeys.taskPriorityTable]?[provider
                                  .selectedIndices[IndexKeys.priorityIndex]]
                              [AppKeys.color]),
                      text: data[SupabaseKeys.taskPriorityTable]?[provider
                                  .selectedIndices[IndexKeys.priorityIndex]]
                              [AppKeys.name] ??
                          ""),
                  indexKey: IndexKeys.priorityIndex,
                  isSalesperson: true,
                ),
                _buildDivider(),
                AgencyRequiredSwitch(isSalesperson: widget.isSalesperson),
                _buildDynamicRow(
                  context: context,
                  label: UserRole.agency.role,
                  dataList: data[AppKeys.fetchedAgencies],
                  widget: OverlappingCircles(
                    bgColors: data[AppKeys.fetchedAgencies]!
                        .map(
                          (user) => provider.stringToColor(
                            user[UserDetails.profileBgColor],
                          ),
                        )
                        .toList(),
                    displayNames: data[AppKeys.fetchedAgencies]!
                        .map((user) => user[UserDetails.name] as String)
                        .toList(),
                  ),
                  indexKey: IndexKeys.agencyIndex,
                  isSalesperson:
                      widget.isSalesperson && provider.isAgencyRequired,
                ),
                MeasurementWidget(),

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

                AppPaddings.gapH(70),
              ]),
            );
          },
        ),
        persistentFooterButtons: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
            child: ActionBtn(
              btnTxt: widget.isNewTask
                  ? 'Create Task'
                  : widget.isSalesperson
                      ? 'Edit Task'
                      : 'Mark as In Progress',
              onPress: () async {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: AppConsts.radius,
                        side: BorderSide(width: 2),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.isNewTask
                                ? 'Create Task'
                                : widget.isSalesperson
                                    ? 'Edit Task'
                                    : 'Confirm Change',
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
                                  btnTxt: widget.isNewTask
                                      ? 'Create'
                                      : widget.isSalesperson
                                          ? 'Edit'
                                          : 'Confirm Change',
                                  onPress: () async {
                                    widget.isNewTask
                                        ? await TaskProvider.instance
                                            .createTask(
                                            nameController.text,
                                            remarkController.text,
                                          )
                                        : await TaskProvider.instance
                                            .updateTask(
                                            nameController.text,
                                            remarkController.text,
                                            widget.dealNo,
                                          );
                                    // await TaskProvider.instance.fetchAllData();
                                    Navigator.of(context).pop();
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
        ],
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
            borderRadius: AppConsts.radius,
          ),
          child: Icon(icon, size: 32),
        ),
        AppPaddings.gapW(10),
        Expanded(child: widget),
      ],
    );
  }

  Widget _buildDynamicRow({
    required bool isSalesperson,
    required BuildContext context,
    required String label,
    required String indexKey,
    required List<Map<String, dynamic>>? dataList,
    required Widget widget,
  }) {
    return Visibility(
      visible: isSalesperson,
      child: Padding(
        padding: AppPaddings.appPadding,
        child: _buildRowWithTextAndWidget(
          label: label,
          widget: widget,
          onTap: () =>
              showClientsBottomSheet(context, dataList ?? [], label, indexKey),
        ),
      ),
    );
  }

  Widget _dropdownWidget({
    required BuildContext context,
    required List<Map<String, dynamic>>? dataList,
    required int index,
    required String title,
    required String name,
    required String indexKey,
    required String defaultText,
    required bool isNewTask,
    required String dealNo,
  }) {
    return ClientNameDropdown(
      name: dataList?.isNotEmpty == true ? dataList![index][name] : defaultText,
      clientList: dataList ?? [],
      onTap: () =>
          showClientsBottomSheet(context, dataList ?? [], title, indexKey),
      dealNo: dealNo,
      isNewTask: isNewTask,
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

  Widget _buildDivider({double verticalPadding = 0}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      child: Divider(color: AppColors.primary),
    );
  }
}

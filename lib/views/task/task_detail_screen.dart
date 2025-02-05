import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_consts.dart';
import '../../constants/enums.dart';
import '../../constants/app_keys.dart';
import '../../extensions/app_paddings.dart';
import '../../providers/task_provider.dart';
import '../home/pages/task%20list/widgets/overlapping_circles.dart';
import 'widgets/agency_required_switch.dart';
import 'widgets/task_detail_widgets.dart';
import 'widgets/due_date_picker.dart';
import 'widgets/measurement/widgets/measurement_widget.dart';
import '../../widgets/action_button.dart';
import '../../widgets/custom_tag.dart';
import '../../widgets/custom_text_field.dart';

class TaskDetailScreen extends StatefulWidget {
  final bool isSalesperson;
  final bool isNewTask;
  final String dealNo;

  const TaskDetailScreen({
    super.key,
    required this.isSalesperson,
    required this.isNewTask,
    required this.dealNo,
  });

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  // final FocusNode nameFocusNode = FocusNode();
  // final FocusNode remarkFocusNode = FocusNode();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus();
    });

    if (!widget.isNewTask) {
      TaskProvider.instance.getTaskByDealNo(
        widget.dealNo,
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    // TaskProvider.instance.nameController.dispose();
    // TaskProvider.instance.remarkController.dispose();
    TaskProvider.instance.resetTaskIndexes();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerTheme: const DividerThemeData(
              color: Colors.transparent,
            ),
          ),
          child: Scaffold(
            extendBody: true,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              forceMaterialTransparency: true,
              title: Text(
                'Task Details',
                style: AppTexts.appBarStyle,
              ),
            ),
            body: Consumer<TaskProvider>(
              builder: (context, provider, child) {
                final data = provider.fetchedData;

                return Padding(
                  padding: AppPaddings.appPadding,
                  child: ListView(children: [
                    RowWithIconAndWidget(
                      icon: Icons.person_2_rounded,
                      widget: DropDownWidget(
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
                    20.hGap,
                    CustomTextField(
                      controller: TextEditingController(
                          text:
                              'This is a demo address textThis is a demo address textThis is a demo address textThis is a demo address text'),
                      isEnabled: false,
                      labelTxt: 'Address',
                      keyboardType: TextInputType.multiline,
                      isMultiline: true,
                    ),
                    20.hGap,

                    CustomTextField(
                      controller: TextEditingController(text: '8490088688'),
                      isEnabled: false,
                      labelTxt: 'Contact Information',
                      isPhone: true,
                    ),
                    AppConsts.buildDivider(verticalPadding: 10),
                    10.hGap,
                    CustomTextField(
                      controller: TaskProvider.instance.nameController,
                      // focusNode: nameFocusNode,
                      labelTxt: 'Task Name',
                      hintTxt: 'Task Name',
                    ),
                    20.hGap,
                    CustomTextField(
                      controller: TaskProvider.instance.remarkController,
                      // focusNode: remarkFocusNode,
                      labelTxt: 'Remarks',
                      hintTxt: 'Remarks',
                      isMultiline: true,
                    ),
                    20.hGap,
                    DatePickerWidget(isNewTask: false),
                    10.hGap,
                    AppConsts.buildDivider(),
                    DynamicRow(
                      context: context,
                      label: 'Status',
                      isStatus: true,
                      dataList: data[SupabaseKeys.taskStatusTable],
                      widget: CustomTag(
                          color: provider.stringToColor(
                              data[SupabaseKeys.taskStatusTable]?[provider
                                      .selectedIndices[IndexKeys.statusIndex]]
                                  [AppKeys.color]),
                          text: data[SupabaseKeys.taskStatusTable]?[provider
                                      .selectedIndices[IndexKeys.statusIndex]]
                                  [AppKeys.name] ??
                              ""),
                      indexKey: IndexKeys.statusIndex,
                      isSalesperson: true,
                    ),
                    DynamicRow(
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
                    DynamicRow(
                      context: context,
                      label: 'Designers',
                      dataList: data[AppKeys.fetchedDesigners],
                      widget: provider.selectedIndices[IndexKeys.designerIndex]!
                              .isNotEmpty
                          ? OverlappingCircles(
                              bgColors: (data[AppKeys.fetchedDesigners] ?? [])
                                  .map(
                                    (user) => provider.stringToColor(
                                      user[UserDetails.profileBgColor],
                                    ),
                                  )
                                  .toList(),
                              displayNames:
                                  (data[AppKeys.fetchedDesigners] ?? [])
                                      .map((user) =>
                                          user[UserDetails.name] as String)
                                      .toList(),
                            )
                          : Text(
                              'None',
                              style: AppTexts.headingStyle,
                            ),
                      indexKey: IndexKeys.designerIndex,
                      isSalesperson: widget.isSalesperson,
                    ),
                    DynamicRow(
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
                    AppConsts.buildDivider(),
                    AgencyRequiredSwitch(isSalesperson: widget.isSalesperson),
                    DynamicRow(
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
                    MeasurementWidget(
                      isNewTask: widget.isNewTask,
                    ),
                    // AppConsts.buildDivider(),
                    // AttachmentsList(
                    //   attachmentsList: [
                    //     {
                    //       "id": "1c92cb0c-f0f1-4715-a5ad-8104952847e7",
                    //       "attachment_url":
                    //           "https://dpgwbagzdsabjejngivi.supabase.co/storage/v1/object/public/bucket/25-0019/ss.png",
                    //       "task_id": "d476cc80-a212-4b2b-bfc2-9e002c0cd8d2",
                    //       "created_at": "2025-01-02T07:35:50.240763+00:00",
                    //       "attachment_name": "attachment 2"
                    //     },
                    //     {
                    //       "id": "1c92cb0c-f0f1-4715-a5ad-8104952847e7",
                    //       "attachment_url":
                    //           "https://dpgwbagzdsabjejngivi.supabase.co/storage/v1/object/public/bucket/25-0019/generated.pdf",
                    //       "task_id": "d476cc80-a212-4b2b-bfc2-9e002c0cd8d2",
                    //       "created_at": "2025-01-02T07:35:50.240763+00:00",
                    //       "attachment_name": "ss.png"
                    //     }
                    //   ],
                    //   dealNo: widget.dealNo,
                    // ),

                    // AppPaddings.gapH(70),
                  ]),
                );
              },
            ),
            persistentFooterButtons: [
              ActionBtn(
                btnTxt: widget.isNewTask
                    ? 'Create Task'
                    : widget.isSalesperson
                        ? 'Edit Task'
                        : 'Mark as In Progress',
                onPress: () async {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: AppBorders.radius,
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
                            style: AppTexts.headingStyle,
                          ),
                          20.hGap,
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
                              10.wGap,
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
                                            TaskProvider
                                                .instance.nameController.text,
                                            TaskProvider
                                                .instance.remarkController.text,
                                          )
                                        : await TaskProvider.instance
                                            .updateTask(
                                            TaskProvider
                                                .instance.nameController.text,
                                            TaskProvider
                                                .instance.remarkController.text,
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
                    ),
                  );
                },
                fontColor: AppColors.primary,
                backgroundColor: AppColors.orange,
              ),
            ],
          ),
        ),
      );
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../data/models/taskWithDetails.dart';
import '../../../data/models/taskWithUser.dart';
import '../../../utils/constants/app_consts.dart';
import '../../../utils/constants/app_keys.dart';
import '../../../utils/constants/dummy_data.dart';
import '../../../utils/constants/enums/user_role.dart';
import '../../../utils/extensions/app_paddings.dart';
import '../../../utils/extensions/color_extension.dart';
import '../../providers/home_provider.dart';
import '../../providers/task_provider.dart';
import '../../widgets/action_button.dart';
import '../../widgets/custom_text_field.dart';
import '../home/pages/task list/widgets/overlapping_circles.dart';
import '../home/pages/widgets/custom_tag.dart';
import 'widgets/old/agency_required_switch.dart';
import 'widgets/old/due_date_picker.dart';
import 'widgets/old/measurement/widgets/measurement_widget.dart';
import 'widgets/old/task_detail_widgets.dart';

class TaskDetailScreen extends StatefulWidget {
  final bool isSalesperson;
  final bool isNewTask;
  final String taskId;

  const TaskDetailScreen({
    super.key,
    required this.isSalesperson,
    required this.isNewTask,
    required this.taskId,
  });

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  late TaskWithDetails? taskDetails;

  @override
  void initState() {
    super.initState();

    // if (!widget.isNewTask) {
    Future.microtask(() async {
      await Provider.of<TaskProvider>(context, listen: false)
          .fetchTask(widget.taskId);
      Provider.of<TaskProvider>(context, listen: false).initializeControllers();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus();
    });
    // }
  }

  @override
  void dispose() {
    // TaskProvider.instance.resetTaskIndexes();
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
                taskDetails = provider.selectedTaskWithDetails!;

                if (taskDetails == null) {
                  return Center(child: Text('No task data available'));
                }

                final HomeProvider homeProvider =
                    Provider.of<HomeProvider>(context, listen: false);

                return Skeletonizer(
                  enabled: provider.isLoading,
                  enableSwitchAnimation: true,
                  effect: ShimmerEffect(),
                  textBoneBorderRadius:
                      TextBoneBorderRadius(BorderRadius.circular(10)),
                  containersColor: Colors.grey,
                  child: ListView(children: [
                    RowWithIconAndWidget(
                      icon: Icons.person_2_rounded,
                      widget: DropDownWidget(
                        context: context,
                        dataList: homeProvider.clients,
                        title: 'Clients',
                        index:
                            provider.selectedIndices[IndexKeys.clientIndex] ??
                                0,
                        name: 'name',
                        indexKey: 'client',
                        defaultText: "No Clients Yet",
                        isNewTask: widget.isNewTask,
                        dealNo: 'widget.dealNo',
                      ),
                    ),
                    20.hGap,
                    CustomTextField(
                      controller: provider.addressController,
                      isEnabled: false,
                      labelTxt: 'Address',
                      keyboardType: TextInputType.multiline,
                      isMultiline: true,
                    ),
                    20.hGap,
                    CustomTextField(
                      controller: provider.contactController,
                      isEnabled: false,
                      labelTxt: 'Contact Information',
                      isPhone: true,
                    ),
                    AppConsts.buildDivider(verticalPadding: 10),
                    10.hGap,
                    CustomTextField(
                      controller: provider.nameController,
                      // focusNode: nameFocusNode,
                      labelTxt: 'Task Name',
                      hintTxt: 'Task Name',
                    ),
                    20.hGap,
                    CustomTextField(
                      controller: provider.remarkController,
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
                      dataList: homeProvider.statuses,
                      widget: CustomTag(
                        color: homeProvider
                            .statuses[provider
                                    .selectedIndices[IndexKeys.statusIndex] ??
                                0]
                            .color
                            .toColor(),
                        // color: taskDetails!.status.color.toColor(),
                        // text: taskDetails!.status.name,
                        text: homeProvider
                            .statuses[provider
                                    .selectedIndices[IndexKeys.statusIndex] ??
                                0]
                            .name,
                      ),
                      indexKey: IndexKeys.statusIndex,
                      isSalesperson: widget.isSalesperson,
                    ),
                    DynamicRow(
                      context: context,
                      label: 'Assigned For',
                      dataList: homeProvider.users,
                      widget: CustomTag(
                        color: homeProvider
                            .users[provider.selectedIndices[
                                    IndexKeys.salespersonIndex] ??
                                0]
                            .profileBgColor
                            .toColor(),
                        text: homeProvider
                            .users[provider.selectedIndices[
                                    IndexKeys.salespersonIndex] ??
                                0]
                            .name,
                      ),
                      indexKey: IndexKeys.salespersonIndex,
                      isSalesperson: widget.isSalesperson,
                    ),
                    DynamicRow(
                      context: context,
                      label: 'Designers',
                      dataList: homeProvider.designers,
                      widget: taskDetails!.designer.name.isNotEmpty
                          ? CustomTag(
                              color: homeProvider
                                  .designers[provider.selectedIndices[
                                          IndexKeys.designerIndex] ??
                                      0]
                                  .profileBgColor
                                  .toColor(),
                              text: homeProvider
                                  .designers[provider.selectedIndices[
                                          IndexKeys.designerIndex] ??
                                      0]
                                  .name,
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
                      dataList: homeProvider.priorities,
                      widget: CustomTag(
                        color: homeProvider
                            .priorities[provider
                                    .selectedIndices[IndexKeys.priorityIndex] ??
                                0]
                            .color
                            .toColor(),
                        text: homeProvider
                            .priorities[provider
                                    .selectedIndices[IndexKeys.priorityIndex] ??
                                0]
                            .name,
                      ),
                      indexKey: IndexKeys.priorityIndex,
                      isSalesperson: true,
                    ),
                    AppConsts.buildDivider(),
                    AgencyRequiredSwitch(isSalesperson: widget.isSalesperson),
                    DynamicRow(
                      context: context,
                      label: UserRole.agency.role,
                      dataList: homeProvider.users,
                      widget: CustomTag(
                        color: homeProvider
                            .users[provider
                                    .selectedIndices[IndexKeys.agencyIndex] ??
                                0]
                            .profileBgColor
                            .toColor(),
                        text: homeProvider
                            .users[provider
                                    .selectedIndices[IndexKeys.agencyIndex] ??
                                0]
                            .name,
                      ),
                      indexKey: IndexKeys.agencyIndex,
                      isSalesperson:
                          widget.isSalesperson && provider.isAgencyRequired,
                    ),
                    MeasurementWidget(
                      isNewTask: widget.isNewTask,
                    ),
                  ]).padAll(AppPaddings.appPaddingInt),
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
                                    // widget.isNewTask
                                    //     ? await TaskProvider.instance
                                    //         .createTask(
                                    //         TaskProvider
                                    //             .instance.nameController.text,
                                    //         TaskProvider
                                    //             .instance.remarkController.text,
                                    //       )
                                    //     : await TaskProvider.instance
                                    //         .updateTask(
                                    //         TaskProvider
                                    //             .instance.nameController.text,
                                    //         TaskProvider
                                    //             .instance.remarkController.text,
                                    //         widget.dealNo,
                                    //       );
                                    // // await TaskProvider.instance.fetchAllData();
                                    // context.pop();
                                    // context.pop();
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

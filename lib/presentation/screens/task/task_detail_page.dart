import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../data/models/agency.dart';
import '../../../data/models/message.dart';
import '../../../data/models/task.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/constants/custom_icons.dart';
import '../../../utils/constants/dummy_data.dart';
import '../../../utils/extensions/padding.dart';
import '../../providers/home_provider.dart';
import '../../providers/task_provider.dart';
import '../../widgets/action_button.dart';
import '../../widgets/bordered_container.dart';
import '../../widgets/custom_tag.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/drop_down_menu.dart';
import '../../widgets/tab_header.dart';
import '../../widgets/tile_row.dart';

final timeline = DummyData.taskDetailTimeline;

class TaskDetailPage extends StatelessWidget {
  const TaskDetailPage({required this.task, super.key});

  final Task task;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      forceMaterialTransparency: true,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text(task.name, style: AppTexts.titleTextStyle)],
      ),
    ),
    body: SafeArea(
      child: Consumer2<TaskProvider, HomeProvider>(
        builder:
            (context, provider, home, child) => SingleChildScrollView(
              child: Column(
                children: [
                  BorderedContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              task.customer,
                              style: AppTexts.titleTextStyle.copyWith(
                                fontVariations: [FontVariation.weight(500)],
                              ),
                            ),
                            IconButton(
                              onPressed:
                                  () => context.replace(
                                    AppRoutes.editTask,
                                    extra: {'task': task, 'isNew': false},
                                  ),
                              icon: Icon(
                                CustomIcon.squarePen,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            CustomTag(
                              text: task.priority,
                              color: Colors.redAccent,
                              textColor: Colors.white,
                            ),
                            10.wGap,
                            CustomTag(
                              text: task.status,
                              color: Colors.black,
                              textColor: Colors.white,
                            ),
                          ],
                        ),
                        10.hGap,
                        TileRow(
                          key1: 'Due Date',
                          value1: task.dueDate,
                          key2: 'Created',
                          value2: task.createdAt,
                        ),
                        10.hGap,
                        if (!home.isAgency) ...[
                          TileRow(
                            key1: 'Due Date',
                            value1: task.dueDate,
                            key2: 'Created',
                            value2: task.createdAt,
                          ),
                          10.hGap,
                        ],
                        Text('Address', style: AppTexts.inputHintTextStyle),
                        Text(
                          '123 Main St, Anytown, CA 12345',
                          style: AppTexts.inputTextStyle,
                        ),
                        if (task.note != null && task.note!.isNotEmpty) ...[
                          10.hGap,
                          Text('Notes', style: AppTexts.inputHintTextStyle),
                          Text(task.note ?? '', style: AppTexts.inputTextStyle),
                        ],
                        10.hGap,
                        if (provider.isMeasurementSent) ...[
                          BorderedContainer(
                            color: AppColors.bgYellow,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Agency Bill Pending Approval',
                                  style: AppTexts.headingTextStyle,
                                ),
                                10.hGap,
                                Text(
                                  'Bill #BILL-123456 from ${task.agency} requires your approval',
                                  style: AppTexts.inputTextStyle,
                                ),
                                10.hGap,
                                ActionButton(
                                  label: 'Review Bill',
                                  onPress:
                                      () => context.push(AppRoutes.reviewBill),
                                  backgroundColor: Colors.black,
                                  fontColor: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (home.isAgency) ...[
                    10.hGap,
                    BorderedContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Measurement Details',
                            style: AppTexts.titleTextStyle,
                          ),
                          20.hGap,
                          Text('Measurements', style: AppTexts.labelTextStyle),
                          5.hGap,
                          ...List.generate(
                            4,
                            (index) => Padding(
                              padding:
                                  index == 0
                                      ? EdgeInsets.zero
                                      : EdgeInsets.only(top: 10.h),
                              child: _buildBorderedTile(
                                'Living Room Window 1',
                                '72" × 48"',
                                'Near the fireplace',
                              ),
                            ),
                          ),
                          20.hGap,
                          Text(
                            'Service Charges',
                            style: AppTexts.labelTextStyle,
                          ),
                          5.hGap,
                          ...List.generate(
                            2,
                            (index) => Padding(
                              padding:
                                  index == 0
                                      ? EdgeInsets.zero
                                      : EdgeInsets.only(top: 10.h),
                              child: _buildBorderedTile(
                                'Curtain Stitching',
                                '\$180.00',
                                'Near the fireplace',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    10.hGap,
                    ActionButton(
                      label: 'Edit Bill',
                      onPress: () => context.push(AppRoutes.measurement),
                      prefixIcon: CustomIcon.receiptIndianRupee,
                    ),
                  ] else ...[
                    TabHeader(
                      tabs: [
                        Tab(text: 'Workflow'),
                        Tab(text: 'Timeline'),
                        Tab(text: 'Messages'),
                      ],
                    ),
                    Builder(
                      builder: (context) {
                        switch (provider.tabIndex) {
                          case 0:
                            return _buildTaskOverFlow(
                              provider.currentAgency,
                              provider.isProductSelected,
                              provider.isMeasurementSent,
                              provider.increaseTaskDetailIndex,
                              provider.setAgency,
                            );
                          case 1:
                            return _buildTimeline();
                          default:
                            return _buildMessages(task.messages);
                        }
                      },
                    ),
                  ],
                ],
              ).padAll(AppPaddings.appPaddingInt),
            ),
      ),
    ),
  );

  BorderedContainer _buildBorderedTile(String title, amount, subtitle) =>
      BorderedContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: AppTexts.labelTextStyle),
                Text(amount, style: AppTexts.labelTextStyle),
              ],
            ),
            Text(subtitle, style: AppTexts.inputHintTextStyle),
          ],
        ),
      );

  Widget _buildTaskOverFlow(
    String selectedAgency,
    bool isProductSelected,
    bool isMeasurementSent,
    VoidCallback increment,
    Function(String) selection,
  ) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Task Workflow', style: AppTexts.titleTextStyle),
      10.hGap,
      BorderedContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isMeasurementSent
                ? Container(
                  padding: EdgeInsets.all(AppPaddings.appPaddingInt),
                  decoration: BoxDecoration(
                    borderRadius: AppBorders.radius,
                    color: AppColors.blueBg,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Measurement Scheduled",
                        style: AppTexts.inputTextStyle.copyWith(
                          color: AppColors.darkBlueText,
                        ),
                      ),
                      10.hGap,
                      Text(
                        "The measurement task has been assigned to $selectedAgency for ${task.createdAt}. Once they complete the measurements, you'll be notified to proceed with creating a quote.",
                        style: AppTexts.inputTextStyle.copyWith(
                          color: AppColors.darkBlueText,
                        ),
                      ),
                    ],
                  ),
                )
                : SizedBox.shrink(),
            isMeasurementSent
                ? SizedBox.shrink()
                : Text(
                  isProductSelected
                      ? "Assign a measurement task to one of our partner agencies."
                      : "The customer is currently in the product selection stage. Once they've selected their products, you can move to the measurement stage.",

                  style: AppTexts.inputTextStyle,
                ),
            if (isProductSelected) ...[
              _buildDropDown('Select Agency', Agency.names),
              _buildTextInput('Schedule Date', 'Select Date'),
              _buildTextInput(
                'Instructions for Agency',
                'Provide any specific instructions',
                isMultiline: true,
              ),
            ],
            10.hGap,
            ActionButton(
              label:
                  isMeasurementSent
                      ? 'Mark Measurement as Complete'
                      : isProductSelected
                      ? 'Assign Measurement Task'
                      : 'Complete Product Selection',
              onPress: () => isMeasurementSent ? null : increment(),
              prefixIcon: CustomIcon.circleCheckBig,
              backgroundColor: Colors.black,
              fontColor: Colors.white,
            ),
          ],
        ),
      ),
    ],
  );

  Widget _buildTextInput(
    String title,
    String hint, {
    bool isMultiline = false,
  }) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: AppTexts.labelTextStyle),
      10.hGap,
      CustomTextField(hintTxt: hint, isMultiline: isMultiline),
      10.hGap,
    ],
  );

  Widget _buildDropDown(String title, List<String> items) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: AppTexts.labelTextStyle),
      10.hGap,
      CustomDropdownMenu(items: items),
      10.hGap,
    ],
  );

  Widget _buildTimeline() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Task Timeline', style: AppTexts.titleTextStyle),
      10.hGap,
      BorderedContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'History of events for this task',
              style: AppTexts.inputHintTextStyle,
            ),
            20.hGap,
            ...List.generate(
              timeline.length,
              (index) => Padding(
                padding:
                    index == 0 ? EdgeInsets.zero : EdgeInsets.only(top: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTag(
                      text: timeline[index]['time'],
                      color:
                          index == 0 ? AppColors.darkBlueText : AppColors.green,
                      textColor: Colors.white,
                    ),
                    5.hGap,
                    Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: Text(
                        timeline[index]['title'],
                        style: AppTexts.labelTextStyle,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: Text(
                        timeline[index]['subtitle'],
                        style: AppTexts.inputHintTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );

  Widget _buildMessages(List<Message> messages) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Task Messages', style: AppTexts.titleTextStyle),
      10.hGap,
      BorderedContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...List.generate(
              messages.length,
              (index) => Padding(
                padding:
                    index == 0 ? EdgeInsets.zero : EdgeInsets.only(top: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          messages[index].name,
                          style: AppTexts.labelTextStyle,
                        ),
                        10.wGap,
                        Text(
                          messages[index].createdAt,
                          style: AppTexts.inputHintTextStyle,
                        ),
                      ],
                    ),
                    5.hGap,
                    Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: Text(
                        messages[index].message,
                        style: AppTexts.inputLabelTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

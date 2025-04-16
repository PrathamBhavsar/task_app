import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../data/models/task.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/constants/dummy_data.dart';
import '../../../utils/extensions/padding.dart';
import '../../providers/task_provider.dart';
import '../../widgets/action_button.dart';
import '../../widgets/bordered_container.dart';
import '../../widgets/custom_tag.dart';
import '../../widgets/tab_header.dart';
import '../../widgets/tile_row.dart';
import '../agency/agency_page.dart';

final timeline = DummyData.taskDetailTimeline;
final messages = DummyData.taskDetailMessages;

class TaskDetailPage extends StatelessWidget {
  const TaskDetailPage({super.key, required this.task});
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
      child: Consumer<TaskProvider>(
        builder:
            (context, provider, child) => SingleChildScrollView(
              child: Column(
                children: [
                  BorderedContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTag(
                          text: task.status,
                          color: Colors.black,
                          textColor: Colors.white,
                        ),
                        5.hGap,
                        Text(
                          task.customer,
                          style: AppTexts.titleTextStyle.copyWith(
                            fontVariations: [FontVariation.weight(500)],
                          ),
                        ),
                        Row(
                          children: [
                            IntrinsicWidth(
                              child: ActionButton(
                                label: 'Call',
                                onPress: () {},
                              ),
                            ),
                            10.wGap,
                            IntrinsicWidth(
                              child: ActionButton(
                                label: 'Text',
                                onPress: () {},
                              ),
                            ),
                          ],
                        ),
                        10.hGap,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Priority',
                                  style: AppTexts.inputHintTextStyle,
                                ),
                                CustomTag(
                                  text: task.priority,
                                  color: Colors.redAccent,
                                  textColor: Colors.white,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Product',
                                  style: AppTexts.inputHintTextStyle,
                                ),
                                Text(
                                  task.product,
                                  style: AppTexts.inputTextStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                        5.hGap,
                        TileRow(
                          key1: 'Due Date',
                          value1: task.dueDate,
                          key2: 'Created',
                          value2: task.createdAt,
                        ),
                        10.hGap,
                        Text('Notes', style: AppTexts.inputHintTextStyle),
                        Text(
                          'Customer is interested in custom blinds for their living room and bedroom. They prefer neutral colors and are concerned about light filtering capabilities.',
                          style: AppTexts.inputTextStyle,
                        ),
                        10.hGap,
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
                                'Bill #BILL-123456 from MeasurePro Services requires your approval',
                                style: AppTexts.inputTextStyle,
                              ),
                              10.hGap,
                              ActionButton(
                                label: 'Review Bill',
                                onPress: () {},
                                backgroundColor: Colors.black,
                                fontColor: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  TabHeader(
                    tabs: [
                      Tab(text: 'Workflow'),
                      Tab(text: 'Timeline'),
                      Tab(text: 'Messages'),
                    ],
                  ),
                  10.hGap,
                  Builder(
                    builder: (context) {
                      switch (provider.tabIndex) {
                        case 0:
                          return _buildTaskOverFlow();
                        case 1:
                          return _buildTimeline();
                        default:
                          return _buildMessages();
                      }
                    },
                  ),
                ],
              ).padAll(AppPaddings.appPaddingInt),
            ),
      ),
    ),
  );
  Widget _buildTaskOverFlow() => BorderedContainer(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Task Workflow', style: AppTexts.titleTextStyle),
        10.hGap,

        // Text(
        //   "The customer is currently in the product selection stage. Once they've selected their products, you can move to the measurement stage.",
        //   style: AppTexts.inputTextStyle,
        // ),
        Text(
          "Assign a measurement task to one of our partner agencies.",
          style: AppTexts.inputTextStyle,
        ),
        10.hGap,
        Text("Select Agency", style: AppTexts.inputTextStyle),
        10.hGap,
        ...List.generate(
          agencies.length,
          (index) => Padding(
            padding: index == 0 ? EdgeInsets.zero : EdgeInsets.only(top: 10.h),
            child: BorderedContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        agencies[index].name,
                        style: AppTexts.labelTextStyle,
                      ),
                      Text(
                        '${agencies[index].rating}/5',
                        style: AppTexts.inputHintTextStyle,
                      ),
                    ],
                  ),
                  Text(
                    'Availability: Next Week',
                    style: AppTexts.inputHintTextStyle,
                  ),
                ],
              ),
            ),
          ),
        ),
        10.hGap,
        Text('Schedule Date', style: AppTexts.inputHintTextStyle),
        10.hGap,
        ActionButton(
          label: 'Complete Product Selection',
          onPress: () {},
          backgroundColor: Colors.black,
          fontColor: Colors.white,
        ),
      ],
    ),
  );

  Widget _buildTimeline() => BorderedContainer(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Task Timeline', style: AppTexts.titleTextStyle),
        Text(
          'History of events for this task',
          style: AppTexts.inputHintTextStyle,
        ),
        20.hGap,
        ...List.generate(
          timeline.length,
          (index) => Padding(
            padding: index == 0 ? EdgeInsets.zero : EdgeInsets.only(top: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTag(
                  text: timeline[index]['time'],
                  color: index == 0 ? AppColors.blue : AppColors.green,
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
  );

  Widget _buildMessages() => BorderedContainer(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Task Messages', style: AppTexts.titleTextStyle),
        20.hGap,
        ...List.generate(
          messages.length,
          (index) => Padding(
            padding: index == 0 ? EdgeInsets.zero : EdgeInsets.only(top: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      messages[index]['title'],
                      style: AppTexts.labelTextStyle,
                    ),
                    10.wGap,
                    Text(
                      messages[index]['time'],
                      style: AppTexts.inputHintTextStyle,
                    ),
                  ],
                ),
                5.hGap,
                Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Text(
                    messages[index]['subtitle'],
                    style: AppTexts.inputLabelTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

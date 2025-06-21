import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/di/di.dart';
import '../../../core/helpers/cache_helper.dart';
import '../../../core/helpers/validator.dart';
import '../../../data/models/payloads/message_payload.dart';
import '../../../domain/entities/message.dart';
import '../../../domain/entities/task.dart';
import '../../../domain/entities/timeline.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/constants/custom_icons.dart';
import '../../../utils/constants/dummy_data.dart';
import '../../../utils/enums/user_role.dart';
import '../../../utils/extensions/color_translator.dart';
import '../../../utils/extensions/date_formatter.dart';
import '../../../utils/extensions/padding.dart';
import '../../blocs/home/home_state.dart';
import '../../blocs/message/message_bloc.dart';
import '../../blocs/message/message_event.dart';
import '../../blocs/message/message_state.dart';
import '../../blocs/tab/tab_bloc.dart';
import '../../blocs/task/task_bloc.dart';
import '../../blocs/task/task_state.dart';
import '../../blocs/timeline/timeline_bloc.dart';
import '../../blocs/timeline/timeline_event.dart';
import '../../blocs/timeline/timeline_state.dart';
import '../../providers/task_provider.dart';
import '../../widgets/action_button.dart';
import '../../widgets/bordered_container.dart';
import '../../widgets/custom_tag.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/drop_down_menu.dart';
import '../../widgets/tab_header.dart';
import '../../widgets/tile_row.dart';
import 'widgets/message_tile.dart';
import 'widgets/timeline_tile.dart';

class TaskDetailPage extends StatefulWidget {
  const TaskDetailPage({required this.task, super.key});

  final Task task;

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  late final TextEditingController _messageController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _messageController = TextEditingController();
    context.read<TimelineBloc>().add(
      FetchTimelinesRequested(widget.task.taskId!),
    );
    context.read<MessageBloc>().add(
      FetchMessagesRequested(widget.task.taskId!),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final int tabIndex = context.select<TabBloc, int>(
      (bloc) => bloc.state.tabIndex,
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text(widget.task.name, style: AppTexts.titleTextStyle)],
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            final UserRole userRole = getIt<CacheHelper>().getUserRole();

            return SingleChildScrollView(
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
                              widget.task.client.name,
                              style: AppTexts.titleTextStyle.copyWith(
                                fontVariations: [FontVariation.weight(500)],
                              ),
                            ),
                            IconButton(
                              onPressed:
                                  () => context.replace(
                                    AppRoutes.editTask,
                                    extra: {
                                      'task': widget.task,
                                      'isNew': false,
                                    },
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
                              text: widget.task.priority.name,
                              color: widget.task.priority.color.toColor(),
                              textColor: Colors.white,
                            ),
                            10.wGap,
                            CustomTag(
                              text: widget.task.status.name,
                              color: widget.task.status.color.toColor(),
                              textColor: Colors.white,
                            ),
                          ],
                        ),
                        10.hGap,
                        TileRow(
                          key1: 'Due Date',
                          value1: widget.task.dueDate.toPrettyDate(),
                          key2: 'Created',
                          value2: widget.task.createdAt.toPrettyDateTime(),
                        ),
                        10.hGap,
                        if (userRole != UserRole.agent) ...[
                          TileRow(
                            key1: 'Due Date',
                            value1: widget.task.dueDate.toPrettyDate(),
                            key2: 'Created',
                            value2: widget.task.createdAt.toPrettyDateTime(),
                          ),
                          10.hGap,
                        ],
                        Text('Address', style: AppTexts.inputHintTextStyle),
                        Text(
                          widget.task.client.address,
                          style: AppTexts.inputTextStyle,
                        ),
                        if (widget.task.notes != null &&
                            widget.task.notes!.isNotEmpty) ...[
                          10.hGap,
                          Text('Notes', style: AppTexts.inputHintTextStyle),
                          Text(
                            widget.task.notes ?? '',
                            style: AppTexts.inputTextStyle,
                          ),
                        ],
                        10.hGap,
                        if (tabIndex == 0) ...[
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
                                  'Bill #BILL-123456 from ${widget.task.agency?.name} requires your approval',
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
                  userRole == UserRole.agent
                      ? _buildAgentView(tabIndex)
                      : _buildNonAgentView(tabIndex),
                ],
              ).padAll(AppPaddings.appPaddingInt),
            );
          },
        ),
      ),
      persistentFooterButtons:
          tabIndex == 2
              ? [
                Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: Form(
                    key: _formKey,
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            hintTxt: "Enter Message",
                            controller: _messageController,
                            validator: Validator.validateRequiredField,
                          ),
                        ),
                        10.wGap,
                        IconButton(
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }

                            FocusScope.of(context).unfocus();

                            context.read<MessageBloc>().add(
                              PutMessageRequested(
                                MessagePayload(
                                  userId: getIt<CacheHelper>().getUserId()!,
                                  taskId: widget.task.taskId!,
                                  message: _messageController.text,
                                ),
                              ),
                            );
                            _messageController.clear();
                          },
                          icon: Icon(Icons.send_outlined, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ]
              : null,
    );
  }

  Widget _buildTaskOverFlow(
    String selectedAgency,
    bool isProductSelected,
    bool isMeasurementSent,
  ) {
    return Column(
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
                          "The measurement task has been assigned to $selectedAgency for ${widget.task.createdAt}. Once they complete the measurements, you'll be notified to proceed with creating a quote.",
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
                // _buildDropDown('Select Agency', Agency.names),
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
                onPress: () {},
                prefixIcon: CustomIcon.circleCheckBig,
                backgroundColor: Colors.black,
                fontColor: Colors.white,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimeline() {
    return BlocBuilder<TimelineBloc, TimelineState>(
      builder: (context, timelineState) {
        if (timelineState is TimelineLoadInProgress) {
          return const Center(child: CircularProgressIndicator());
        }

        if (timelineState is TimelineLoadFailure) {
          return const Center(child: Text('There was an issue loading bills!'));
        }

        if (timelineState is TimelineLoadSuccess) {
          final timelines = timelineState.timelines;

          if (timelines.isEmpty) {
            return const Center(child: Text('There are no bills!'));
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Task Timeline', style: AppTexts.titleTextStyle),
              Text(
                'History of events for this task',
                style: AppTexts.inputHintTextStyle,
              ),
              10.hGap,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: timelineState.timelines.length,
                    itemBuilder:
                        (context, index) => TimelineTile(
                          timeline: timelineState.timelines[index],
                        ),
                    separatorBuilder: (context, index) => 20.hGap,
                  ),
                ],
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildMessages() {
    return BlocConsumer<MessageBloc, MessageState>(
      listener: (context, state) {
        if (state is PutMessageSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<MessageBloc>().add(
              FetchMessagesRequested(widget.task.taskId!),
            );
          });
        }
      },
      builder: (BuildContext context, messageState) {
        if (messageState is MessageLoadInProgress) {
          return const Center(child: CircularProgressIndicator());
        }

        if (messageState is MessageLoadFailure) {
          return const Center(
            child: Text('There was an issue loading messages!'),
          );
        }

        if (messageState is MessageLoadSuccess) {
          final messages = messageState.messages;

          if (messages.isEmpty) {
            return const Center(child: Text('There are no messages!'));
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Task Messages', style: AppTexts.titleTextStyle),
              10.hGap,
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: messageState.messages.length,
                itemBuilder:
                    (context, index) =>
                        MessageTile(message: messageState.messages[index]),
                separatorBuilder: (context, index) => 10.hGap,
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildAgentView(int tabIndex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        10.hGap,
        BorderedContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Measurement Details', style: AppTexts.titleTextStyle),
              20.hGap,
              Text('Measurements', style: AppTexts.labelTextStyle),
              5.hGap,
              ...List.generate(
                4,
                (index) => Padding(
                  padding:
                      index == 0 ? EdgeInsets.zero : EdgeInsets.only(top: 10.h),
                  child: _buildBorderedTile(
                    'Living Room Window 1',
                    '72" × 48"',
                    'Near the fireplace',
                  ),
                ),
              ),
              20.hGap,
              Text('Service Charges', style: AppTexts.labelTextStyle),
              5.hGap,
              ...List.generate(
                2,
                (index) => Padding(
                  padding:
                      index == 0 ? EdgeInsets.zero : EdgeInsets.only(top: 10.h),
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
      ],
    );
  }

  Widget _buildNonAgentView(int tabIndex) {
    return Column(
      children: [
        TabHeader(
          tabs: [
            Tab(text: 'Workflow'),
            Tab(text: 'Timeline'),
            Tab(text: 'Messages'),
          ],
        ),
        IndexedStack(
          index: tabIndex,
          children: [
            _buildTaskOverFlow(
              widget.task.agency?.name ?? "",
              tabIndex == 1,
              tabIndex == 2,
            ),
            _buildTimeline(),
            _buildMessages(),
          ],
        ),
        // Builder(
        //   builder: (context) {
        //     switch (tabIndex) {
        //       case 0:
        //         return _buildTaskOverFlow(
        //           widget.task.agency?.name ?? "",
        //           tabIndex == 1,
        //           tabIndex == 2,
        //         );
        //       case 1:
        //         return _buildTimeline();
        //       default:
        //         // return SizedBox.shrink();
        //         return _buildMessages();
        //     }
        //   },
        // ),
      ],
    );
  }

  BorderedContainer _buildBorderedTile(String title, amount, subtitle) {
    return BorderedContainer(
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
  }

  Widget _buildTextInput(
    String title,
    String hint, {
    bool isMultiline = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTexts.labelTextStyle),
        10.hGap,
        CustomTextField(hintTxt: hint, isMultiline: isMultiline),
        10.hGap,
      ],
    );
  }

}
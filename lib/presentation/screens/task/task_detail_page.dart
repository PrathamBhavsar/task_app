import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/di.dart';
import '../../../core/helpers/cache_helper.dart';
import '../../../core/helpers/validator.dart';
import '../../../data/models/payloads/message_payload.dart';
import '../../../data/models/payloads/update_status_payload.dart';
import '../../../domain/entities/client.dart';
import '../../../domain/entities/designer.dart';
import '../../../domain/entities/status.dart';
import '../../../domain/entities/task.dart';
import '../../../domain/entities/timeline.dart';
import '../../../domain/entities/user.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/constants/custom_icons.dart';
import '../../../utils/enums/status_type.dart';
import '../../../utils/enums/user_role.dart';
import '../../../utils/extensions/color_translator.dart';
import '../../../utils/extensions/date_formatter.dart';
import '../../../utils/extensions/padding.dart';
import '../../blocs/client/client_bloc.dart';
import '../../blocs/client/client_state.dart';
import '../../blocs/designer/designer_bloc.dart';
import '../../blocs/designer/designer_state.dart';
import '../../blocs/message/message_bloc.dart';
import '../../blocs/message/message_event.dart';
import '../../blocs/message/message_state.dart';
import '../../blocs/tab/tab_bloc.dart';
import '../../blocs/task/task_bloc.dart';
import '../../blocs/task/task_event.dart';
import '../../blocs/task/task_state.dart';
import '../../blocs/task_form/task_form_bloc.dart';
import '../../blocs/task_form/task_form_event.dart';
import '../../blocs/task_form/task_form_state.dart';
import '../../blocs/timeline/timeline_bloc.dart';
import '../../blocs/timeline/timeline_event.dart';
import '../../blocs/timeline/timeline_state.dart';
import '../../blocs/user/user_bloc.dart';
import '../../blocs/user/user_state.dart';
import '../../widgets/action_button.dart';
import '../../widgets/bordered_container.dart';
import '../../widgets/custom_tag.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/drop_down_menu.dart';
import '../../widgets/refresh_wrapper.dart';
import '../../widgets/tab_header.dart';
import '../../widgets/tile_row.dart';
import 'widgets/message_tile.dart';
import 'widgets/messages_widget.dart';
import 'widgets/timeline_tile.dart';
import 'widgets/timeline_widget.dart';

class TaskDetailPage extends StatefulWidget {
  const TaskDetailPage({required this.task, super.key});

  final Task task;

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  late final TextEditingController _messageController;
  final ScrollController _scrollController = ScrollController();
  final FocusNode _textFieldFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _handleInit();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textFieldFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int tabIndex = context.select<TabBloc, int>(
      (bloc) => bloc.state.tabIndex,
    );

    return Scaffold(
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

            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: SingleChildScrollView(
                controller: _scrollController,
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
                          Text('Address', style: AppTexts.inputHintTextStyle),
                          Text(
                            widget.task.client.address,
                            style: AppTexts.inputTextStyle,
                          ),
                          if (widget.task.remarks != null &&
                              widget.task.remarks!.isNotEmpty) ...[
                            10.hGap,
                            Text('Notes', style: AppTexts.inputHintTextStyle),
                            Text(
                              widget.task.remarks ?? '',
                              style: AppTexts.inputTextStyle,
                            ),
                          ],
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
                      ),
                    ),
                    userRole == UserRole.agent
                        ? _buildAgentView()
                        : _buildNonAgentView(tabIndex),
                  ],
                ).padAll(AppPaddings.appPaddingInt),
              ),
            );
          },
        ),
      ),

      bottomSheet:
          tabIndex == 2
              ? SafeArea(
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(10),
                  child: Form(
                    key: _formKey,
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            focusNode: _textFieldFocusNode,
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
              )
              : SizedBox.shrink(),
    );
  }

  Widget _buildAgentView() {
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
            BlocConsumer<TaskBloc, TaskState>(
              listener: (context, state) {
                if (state is UpdateTaskStatusSuccess) {
                  context.read<TaskBloc>().add(FetchTasksRequested());
                  context.pop();
                }
              },

              builder: (context, state) {
                bool isProductSelected = false;

                if (state is TaskSelectionState) {
                  isProductSelected = state.isProductSelected;
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Task Workflow', style: AppTexts.titleTextStyle),
                    10.hGap,
                    BorderedContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BlocBuilder<TaskFormBloc, TaskFormState>(
                            builder: (context, state) {
                              if (!state.isInitialized) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              if (!isProductSelected) {
                                return const SizedBox.shrink();
                              }

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildDropdown<User>(
                                    title: 'Agency',
                                    list: state.agencies,
                                    initialValue: state.selectedAgency,
                                    onChanged:
                                        (selected) => context
                                            .read<TaskFormBloc>()
                                            .add(AgencyChanged(selected)),
                                    labelBuilder: (a) => a.name,
                                    idBuilder:
                                        (a) => a.userId?.toString() ?? '',
                                  ),
                                  _buildTextInput(
                                    'Schedule Date',
                                    'Select Date',
                                  ),
                                  _buildTextInput(
                                    'Instructions for Agency',
                                    'Provide any specific instructions',
                                    isMultiline: true,
                                  ),
                                ],
                              );
                            },
                          ),
                          Text(
                            isProductSelected
                                ? "Assign a measurement task to one of our partner agencies."
                                : "The customer is currently in the product selection stage. Once they've selected their products, you can move to the measurement stage.",
                            style: AppTexts.inputTextStyle,
                          ),
                          10.hGap,
                          ActionButton(
                            label:
                                isProductSelected
                                    ? 'Assign Measurement Task'
                                    : 'Complete Product Selection',
                            onPress: () {
                              final TaskBloc taskBloc =
                                  context.read<TaskBloc>();
                              if (!isProductSelected) {
                                taskBloc.add(ToggleStatusEvent(true));
                              } else {
                                final int? userId =
                                    getIt<CacheHelper>().getUserId();
                                taskBloc.add(
                                  UpdateTaskStatusRequested(
                                    UpdateStatusPayload(
                                      status:
                                          StatusType.agencyAssigned.status.name,
                                      taskId: widget.task.taskId ?? 0,
                                      agencyId:
                                          context
                                              .read<TaskFormBloc>()
                                              .state
                                              .selectedAgency
                                              ?.userId ??
                                          0,
                                      userId: userId ?? 0,
                                    ),
                                  ),
                                );
                              }
                            },
                            prefixIcon: CustomIcon.circleCheckBig,
                            backgroundColor: Colors.black,
                            fontColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            TimeLineWidget(),
            MessagesWidget(widget: widget),
          ],
        ),
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

  Column _buildDropdown<T>({
    required String title,
    required List<T> list,
    required ValueChanged<T> onChanged,
    T? initialValue,
    String Function(T)? labelBuilder,
    String Function(T)? idBuilder,
  }) {
    final effectiveLabelBuilder = labelBuilder ?? (value) => value.toString();
    final effectiveIdBuilder =
        idBuilder ?? (value) => value.hashCode.toString();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        10.hGap,
        Text(title, style: AppTexts.labelTextStyle),
        10.hGap,
        ModelDropdownMenu<T>(
          items: list,
          initialValue: initialValue,
          onChanged: onChanged,
          labelBuilder: effectiveLabelBuilder,
          idBuilder: effectiveIdBuilder,
        ),
        10.hGap,
      ],
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

  void _handleInit() {
    final clientState = context.read<ClientBloc>().state;
    final List<Client> customerList =
        clientState is ClientLoadSuccess ? clientState.clients : [];

    final designerState = context.read<DesignerBloc>().state;
    final List<Designer> designerList =
        designerState is DesignerLoadSuccess ? designerState.designers : [];

    final userState = context.read<UserBloc>().state;

    final List<User> userList =
        userState is UserLoadSuccess ? userState.users : [];

    final List<User> agencyList =
        userList.where((u) => u.userType == UserRole.agent).toList();

    final TaskFormBloc bloc = context.read<TaskFormBloc>();

    _messageController = TextEditingController();
    _textFieldFocusNode.addListener(() {
      if (_textFieldFocusNode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 100), () {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
          );
        });
      }
    });
    context.read<TimelineBloc>().add(
      FetchTimelinesRequested(widget.task.taskId!),
    );
    context.read<MessageBloc>().add(
      FetchMessagesRequested(widget.task.taskId!),
    );

    bloc.add(
      InitializeTaskForm(
        existingTask: widget.task,
        clients: customerList,
        designers: designerList,
        agencies: agencyList,
      ),
    );
  }
}

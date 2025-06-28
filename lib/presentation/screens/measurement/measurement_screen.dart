import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../core/di/di.dart';
import '../../../core/helpers/cache_helper.dart';
import '../../../data/models/payloads/measurement_payload.dart';
import '../../../data/models/payloads/service_payload.dart';
import '../../../data/models/payloads/update_status_payload.dart';
import '../../../domain/entities/service_master.dart';
import '../../../domain/entities/task.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/constants/custom_icons.dart';
import '../../../utils/enums/status_type.dart';
import '../../../utils/extensions/get_data.dart';
import '../../../utils/extensions/padding.dart';
import '../../blocs/measurement/api/measurement_api_bloc.dart';
import '../../blocs/measurement/api/measurement_api_event.dart';
import '../../blocs/measurement/api/measurement_api_state.dart';
import '../../blocs/measurement/api/service_api_bloc.dart';
import '../../blocs/measurement/api/service_api_event.dart';
import '../../blocs/measurement/api/service_api_state.dart';
import '../../blocs/measurement/measurement_bloc.dart';
import '../../blocs/measurement/measurement_event.dart';
import '../../blocs/measurement/measurement_state.dart';
import '../../blocs/task/task_bloc.dart';
import '../../blocs/task/task_event.dart';
import '../../blocs/task/task_state.dart';
import '../../blocs/task_form/task_form_bloc.dart';
import '../../widgets/action_button.dart';
import '../../widgets/bordered_container.dart';
import '../../widgets/labeled_text_field.dart';
import 'widgets/attachment_tile.dart';
import 'widgets/measurement_tile.dart';
import 'widgets/service_tile.dart';

class MeasurementScreen extends StatefulWidget {
  const MeasurementScreen({required this.task, super.key});

  final Task task;

  @override
  State<MeasurementScreen> createState() => _MeasurementScreenState();
}

class _MeasurementScreenState extends State<MeasurementScreen> {
  bool _isMeasurementSuccess = false;
  bool _isServiceSuccess = false;

  @override
  void initState() {
    context.read<MeasurementBloc>().add(
      InitializeMeasurement(
        existingTask: widget.task,
        serviceMaster: context.serviceMasters.first,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _isMeasurementSuccess = false;
    _isServiceSuccess = false;
    super.dispose();
  }

  void _checkAndPop(BuildContext context) {
    if (_isMeasurementSuccess && _isServiceSuccess) {
      _isMeasurementSuccess = false;
      _isServiceSuccess = false;

      final taskBloc = context.read<TaskBloc>();
      final int? userId = getIt<CacheHelper>().getUserId();
      final selectedAgencyId =
          context.read<TaskFormBloc>().state.selectedAgency?.userId ?? 0;
      taskBloc.add(
        UpdateTaskStatusRequested(
          UpdateStatusPayload(
            status: StatusType.quotationSent.status.name,
            taskId: widget.task.taskId ?? 0,
            agencyId: selectedAgencyId,
            userId: userId ?? 0,
          ),
        ),
      );

      if (taskBloc.state is UpdateTaskStatusSuccess) {
        context.read<MeasurementBloc>().add(ResetMeasurement());
        context.pop();
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Submit Measurements', style: AppTexts.titleTextStyle),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: MultiBlocListener(
              listeners: [
                BlocListener<MeasurementApiBloc, MeasurementApiState>(
                  listener: (context, state) {
                    if (state is PutMeasurementSuccess) {
                      _isMeasurementSuccess = true;
                      _checkAndPop(context);
                    }
                  },
                ),
                BlocListener<ServiceApiBloc, ServiceApiState>(
                  listener: (context, state) {
                    if (state is PutServiceSuccess) {
                      _isServiceSuccess = true;
                      _checkAndPop(context);
                    }
                  },
                ),
              ],
              child: BlocBuilder<MeasurementBloc, MeasurementState>(
                builder: (context, state) {
                  final MeasurementBloc measurementBloc =
                      context.read<MeasurementBloc>();

                  final serviceMasterState =
                      context.read<ServiceApiBloc>().state;
                  final List<ServiceMaster> serviceMasters =
                      switch (serviceMasterState) {
                        ServiceMasterLoadSuccess(:final serviceMasters) =>
                          serviceMasters,
                        _ => [],
                      };

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Enter the measurements for Window Measurement - Johnson Residence',
                        style: AppTexts.inputHintTextStyle,
                      ),
                      20.hGap,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Measurements', style: AppTexts.labelTextStyle),
                          IntrinsicWidth(
                            child: ActionButton(
                              label: 'Add Measurement',
                              prefixIcon: Icons.add,
                              onPress:
                                  () => measurementBloc.add(
                                    MeasurementAdded(widget.task),
                                  ),
                            ),
                          ),
                        ],
                      ),
                      10.hGap,
                      ...List.generate(
                        state.measurements.length,
                        (index) => MeasurementTile(index: index),
                      ),
                      20.hGap,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Service Charges',
                            style: AppTexts.labelTextStyle,
                          ),
                          IntrinsicWidth(
                            child: ActionButton(
                              label: 'Add Service',
                              prefixIcon: Icons.add,
                              onPress:
                                  () => measurementBloc.add(
                                    ServiceAdded(
                                      widget.task,
                                      ServiceMaster(name: "MASTER", rate: 50),
                                    ),
                                  ),
                            ),
                          ),
                        ],
                      ),
                      10.hGap,
                      ...List.generate(
                        state.services.length,
                        (index) => ServiceTile(
                          index: index,
                          service: state.services[index],
                          selectedServiceMaster: serviceMasters.first,
                          serviceMasters: serviceMasters,
                        ),
                      ),
                      Divider(
                        color: AppColors.accent,
                      ).padSymmetric(vertical: 10.h),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'Total: \$${state.totalAmount}',
                          style: AppTexts.labelTextStyle.copyWith(
                            fontVariations: [FontVariation.weight(600)],
                          ),
                        ),
                      ),
                      LabeledTextInput(
                        title: 'Additional Notes',
                        hint: 'Add additional note',
                      ),
                      Text('Attachments', style: AppTexts.labelTextStyle),

                      ...List.generate(
                        state.attachments.length,
                        (index) => AttachmentTile(index: index),
                      ),
                      10.hGap,
                      BorderedContainer(
                        child: Column(
                          children: [
                            Icon(
                              CustomIcon.cloudUpload,
                              size: 30.sp,
                              color: Colors.black,
                            ),
                            Text(
                              'Upload Files',
                              style: AppTexts.headingTextStyle,
                            ),
                            Text(
                              'Upload photos, diagrams, or documents',
                              style: AppTexts.inputHintTextStyle,
                            ),
                            10.hGap,
                            ActionButton(
                              label: 'Browse Files',
                              // onPress: () => provider.addAttachment(),
                              onPress: () {},
                            ),
                          ],
                        ),
                      ),
                      20.hGap,
                      ActionButton(
                        label: 'Submit Measurements',
                        onPress: () {
                          context.read<MeasurementApiBloc>().add(
                            PutMeasurementRequested(
                              MeasurementPayload(
                                measurements: state.measurements,
                              ),
                            ),
                          );

                          context.read<ServiceApiBloc>().add(
                            PutServiceRequested(
                              ServicePayload(services: state.services),
                            ),
                          );
                        },
                        backgroundColor: Colors.black,
                        fontColor: Colors.white,
                      ),
                      10.hGap,
                      ActionButton(label: 'Cancel', onPress: () {}),
                    ],
                  ).padAll(AppPaddings.appPaddingInt);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

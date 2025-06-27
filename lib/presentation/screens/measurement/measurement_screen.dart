import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../data/models/payloads/measurement_payload.dart';
import '../../../data/models/payloads/service_payload.dart';
import '../../../domain/entities/service_master.dart';
import '../../../domain/entities/task.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/constants/custom_icons.dart';
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
import '../../widgets/action_button.dart';
import '../../widgets/bordered_container.dart';
import '../../widgets/labeled_text_field.dart';
import 'widgets/attachment_tile.dart';
import 'widgets/measurement_tile.dart';
import 'widgets/service_tile.dart';

class MeasurementScreen extends StatelessWidget {
  const MeasurementScreen({required this.task, super.key});

  final Task task;

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
            child: BlocConsumer<MeasurementBloc, MeasurementState>(
              listener: (context, state) {
                if (state is PutMeasurementSuccess &&
                    state is PutServiceSuccess) {
                  context.read<MeasurementBloc>().add(ResetMeasurement());

                  context.pop();
                  context.pop();
                }

              },
              builder: (context, state) {
                final MeasurementBloc measurementBloc =
                    context.read<MeasurementBloc>();

                measurementBloc.add(
                  InitializeMeasurement(
                    existingTask: task,
                    serviceMaster: context.serviceMasters.first,
                  ),
                );

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
                                () =>
                                    measurementBloc.add(MeasurementAdded(task)),
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
                        Text('Service Charges', style: AppTexts.labelTextStyle),
                        IntrinsicWidth(
                          child: ActionButton(
                            label: 'Add Service',
                            prefixIcon: Icons.add,
                            onPress:
                                () => measurementBloc.add(
                                  ServiceAdded(
                                    task,
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
                      (index) => ServiceTile(index: index),
                    ),
                    Divider(
                      color: AppColors.accent,
                    ).padSymmetric(vertical: 10.h),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Total: \$0.00',
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
                        // context.read<MeasurementApiBloc>().add(
                        //   PutMeasurementRequested(
                        //     MeasurementPayload(
                        //       measurements: state.measurements,
                        //     ),
                        //   ),
                        // );

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
    );
  }
}

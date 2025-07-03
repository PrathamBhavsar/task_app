import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/task.dart';
import '../../../../domain/entities/user.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/constants/custom_icons.dart';
import '../../../../utils/enums/status_type.dart';
import '../../../../utils/extensions/padding.dart';
import '../../../../utils/extensions/status_type_extractor.dart';
import '../../../../utils/extensions/update_task_status.dart';
import '../../../blocs/task_form/task_form_bloc.dart';
import '../../../blocs/task_form/task_form_event.dart';
import '../../../blocs/task_form/task_form_state.dart';
import '../../../widgets/action_button.dart';
import '../../../widgets/bordered_container.dart';
import '../../../widgets/drop_down_menu.dart';
import '../../../widgets/labeled_text_field.dart';

class TaskWorkflowWidget extends StatelessWidget {
  const TaskWorkflowWidget({required this.task, super.key});

  final Task task;

  @override
  Widget build(BuildContext context) {
    final status = task.status.toStatusType();
    final String agencyName = task.agency?.name ?? "";

    switch (status) {
      case StatusType.created:
        final nextStatus = StatusType.agencyAssigned;
        return _buildAssignAgency(nextStatus, context);

      case StatusType.agencyAssigned:
        return BorderedContainer(
          color: AppColors.blueBg,
          child: Text(
            "This task has been assigned to $agencyName, they'll add the measurements!",
            style: AppTexts.inputTextStyle.copyWith(
              color: AppColors.darkBlueText,
            ),
          ),
        );

      case StatusType.quotationInProgress:
        return BorderedContainer(
          color: AppColors.blueBg,
          child: Text(
            "Quotation for the measurements sent by $agencyName is in progress",
            style: AppTexts.inputTextStyle.copyWith(
              color: AppColors.darkBlueText,
            ),
          ),
        );

      case StatusType.quotationSent:
        return BorderedContainer(
          color: AppColors.blueBg,
          child: Text(
            "Review the quotation sent by $agencyName!",
            style: AppTexts.inputTextStyle.copyWith(
              color: AppColors.darkBlueText,
            ),
          ),
        );

      default:
        return Text(status?.name ?? "NONE");
    }
  }

  Widget _buildAssignAgency(StatusType? nextStatus, BuildContext context) {
    return BorderedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<TaskFormBloc, TaskFormState>(
            builder: (context, state) {
              if (!state.isInitialized) {
                return const Center(child: CircularProgressIndicator());
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDropdown<User>(
                    title: 'Agency',
                    list: state.agencies,
                    initialValue: state.selectedAgency,
                    onChanged:
                        (selected) => context.read<TaskFormBloc>().add(
                          AgencyChanged(selected),
                        ),
                    labelBuilder: (a) => a.name,
                    idBuilder: (a) => a.userId?.toString() ?? '',
                  ),
                  LabeledTextInput(title: 'Schedule Date', hint: 'Select Date'),
                  LabeledTextInput(
                    title: 'Instructions for Agency',
                    hint: 'Provide any specific instructions',
                    isMultiline: true,
                  ),
                ],
              );
            },
          ),
          Text(
            "Assign a measurement task to one of our partner agencies.",
            style: AppTexts.inputTextStyle,
          ),
          10.hGap,
          if (nextStatus != null)
            ActionButton(
              label: 'Move to ${nextStatus.status.name}',
              prefixIcon: CustomIcon.circleCheckBig,
              backgroundColor: Colors.black,
              fontColor: Colors.white,
              onPress: () {
                context.updateTaskStatusToQuotationSent(
                  task: task,
                  context: context,
                );
              },
            ),
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
}

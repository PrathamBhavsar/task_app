import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/di.dart';
import '../../../../core/helpers/cache_helper.dart';
import '../../../../domain/entities/task.dart';
import '../../../../domain/entities/user.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/constants/custom_icons.dart';
import '../../../../utils/enums/status_type.dart';
import '../../../../utils/enums/user_role.dart';
import '../../../../utils/extensions/get_next_status.dart';
import '../../../../utils/extensions/padding.dart';
import '../../../../utils/extensions/status_type_extractor.dart';
import '../../../../utils/extensions/update_task_status.dart';
import '../../../blocs/task_form/task_form_bloc.dart';
import '../../../blocs/task_form/task_form_event.dart';
import '../../../blocs/task_form/task_form_state.dart';
import '../../../widgets/action_button.dart';
import '../../../widgets/bordered_container.dart';
import '../../../widgets/drop_down_menu.dart';

class TaskWorkflowWidget extends StatelessWidget {
  const TaskWorkflowWidget({required this.task, super.key});

  final Task task;

  UserRole get _userRole => getIt<CacheHelper>().getUserRole();

  bool get isAdmin => _userRole == UserRole.admin;

  bool get isAgency => _userRole == UserRole.agent;

  bool get isSalesperson => _userRole == UserRole.salesperson;

  @override
  Widget build(BuildContext context) {
    final status = task.status.toStatusType();
    return _buildContentForStatus(context, status!);
  }

  Widget _buildContentForStatus(BuildContext context, StatusType status) {
    final agencyName = task.agency?.name ?? "";
    final clientName = task.client.name;

    switch (status) {
      case StatusType.created:
        return _buildAssignAgency(context);

      case StatusType.measurementReceived:
        return _infoContainer(
          color: AppColors.blueBg,
          text:
              isAgency
                  ? "You’ve been assigned to this task. Please approve or reject measurements."
                  : "This task has been assigned to $agencyName, they'll approve or reject the measurements!",
        );

      case StatusType.measurementInProgress:
        return _infoContainer(
          color: AppColors.bgYellow,
          text:
              isAgency
                  ? "You’ve accepted this task. Please add the measurements."
                  : "This task has been assigned to $agencyName, they'll add the measurements!",
          textColor: AppColors.darkYellowText,
        );

      case StatusType.measurementRejected:
        return _infoContainer(
          color: AppColors.bgYellow,
          text: "Measurement was rejected by ${isAgency ? "you" : agencyName}.",
          textColor: AppColors.darkYellowText,
        );

      case StatusType.measurementDone:
        return _infoContainer(
          color: AppColors.blueBg,
          text:
              isSalesperson
                  ? "Quotation has been sent. Awaiting approval from $clientName. Approve or reject Quote"
                  : "Review or Update the Measurements & Services sent by ${isAgency ? "you" : agencyName}!",
        );

      case StatusType.billCreated:
        return _infoContainer(
          color: AppColors.blueBg,
          text:
              isAgency
                  ? "Bill has been sent. Awaiting approval"
                  : "Approve or Reject Bill sent by $agencyName!",
        );

      case StatusType.quotationApproved:
        return _infoContainer(
          color: AppColors.blueBg,
          text:
              isSalesperson
                  ? "Please create a quotation for the measurements sent by $agencyName."
                  : "Quotation for the measurements sent by $agencyName is in progress.",
        );

      case StatusType.ordered:
        return _infoContainer(
          color: AppColors.bgYellow,
          text:
              "Materials ordered for $clientName, approve or reject the invoice.",
          textColor: AppColors.darkYellowText,
        );

      case StatusType.invoiceApproved:
        return _infoContainer(
          color: AppColors.bgYellow,
          text: "Approve or reject bill for $clientName.",
          textColor: AppColors.darkYellowText,
        );

      case StatusType.invoiceRejected:
        return _infoContainer(
          color: AppColors.bgYellow,
          text: "Invoice was rejected by $clientName.",
          textColor: AppColors.darkYellowText,
        );

      default:
        return Text(status.name);
    }
  }

  Widget _infoContainer({
    required Color color,
    required String text,
    Color? textColor,
  }) {
    return BorderedContainer(
      color: color,
      child: Text(
        text,
        style: AppTexts.inputTextStyle.copyWith(
          color: textColor ?? AppColors.darkBlueText,
        ),
      ),
    );
  }

  Widget _buildAssignAgency(BuildContext context) {
    return BorderedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<TaskFormBloc, TaskFormState>(
            builder: (context, state) {
              if (!state.isInitialized) {
                return const Center(child: CircularProgressIndicator());
              }

              return _buildDropdown<User>(
                title: 'Agency',
                list: state.agencies,
                initialValue: state.selectedAgency,
                onChanged:
                    (selected) => context.read<TaskFormBloc>().add(
                      AgencyChanged(selected),
                    ),
                labelBuilder: (a) => a.name,
                idBuilder: (a) => a.userId?.toString() ?? '',
              );
            },
          ),
          Text(
            "Assign a measurement task to one of our partner agencies.",
            style: AppTexts.inputTextStyle,
          ),
          10.hGap,
          ActionButton(
            label: 'Move to ${task.status.next!.name}',
            prefixIcon: CustomIcon.circleCheckBig,
            backgroundColor: Colors.black,
            fontColor: Colors.white,
            onPress:
                () => context.updateTaskStatus(task: task, context: context),
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

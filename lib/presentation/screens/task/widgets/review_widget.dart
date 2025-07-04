import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/di.dart';
import '../../../../core/helpers/cache_helper.dart';
import '../../../../core/router/args.dart';
import '../../../../domain/entities/task.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/enums/status_type.dart';
import '../../../../utils/enums/user_role.dart';
import '../../../../utils/extensions/status_type_extractor.dart';
import '../../../../utils/extensions/update_task_status.dart';
import '../../../widgets/action_button.dart';
import 'review_widget_tile.dart';

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({required this.task, super.key});

  final Task task;

  UserRole get _userRole => getIt<CacheHelper>().getUserRole();

  bool get isAdmin => _userRole == UserRole.admin;

  bool get isAgency => _userRole == UserRole.agent;

  bool get isSalesperson => _userRole == UserRole.salesperson;

  @override
  Widget build(BuildContext context) {
    final status = task.status.toStatusType();
    return _buildTileForStatus(context, status!);
  }

  Widget _buildTileForStatus(BuildContext context, StatusType status) {
    switch (status) {
      case StatusType.billCreated:
        return ReviewWidgetTile(
          title: "Bill Approval Required",
          subtitle:
              "Bill #BILL-123456 from ${task.agency?.name ?? ""} requires your approval",
          btnText: "Review Bill",
          onTap: () => context.push(AppRoutes.reviewBill),
        );

      case StatusType.measurementReceived:
        return ReviewWidgetTile(
          title: "Measurement Required",
          subtitle:
              isAgency
                  ? "Please upload measurements for ${task.dealNo}"
                  : "Task ${task.dealNo} from ${task.createdBy.name} requires measurements",
          btnText: isAgency ? "Upload Now" : "Add Measurement",
          onTap:
              () => context.push(
                AppRoutes.measurement,
                extra: MeasurementArgs(task: task),
              ),
        );

      case StatusType.quotationInProgress:
        return ReviewWidgetTile(
          title: "Quotation Approval Required",
          subtitle:
              "Task ${task.dealNo} from ${task.createdBy.name} requires quotation approval",
          btnText: "Review Quotation",
          onTap: () => context.push(AppRoutes.quoteDetails, extra: task),
          child:
              isSalesperson
                  ? ActionButton(
                    label: "Edit Quotation",
                    backgroundColor: Colors.white,
                    fontColor: Colors.black,
                    onPress:
                        () => context.push(AppRoutes.editQuote, extra: task),
                  )
                  : null,
        );

      case StatusType.quotationSent:
        return ReviewWidgetTile(
          title: "Quotation Sent",
          subtitle:
              isSalesperson
                  ? "Quotation sent to ${task.client.name}"
                  : "Task ${task.dealNo} requires quotation approval",
          btnText: "Review Quotation",
          onTap: () => context.push(AppRoutes.editQuote, extra: task),
        );

      case StatusType.quotationApproved:
        return ReviewWidgetTile(
          title: "Order Materials",
          subtitle: "Task ${task.dealNo} approved by ${task.client.name}",
          btnText: "Set as Ordered",
          onTap:
              () => context.updateTaskStatusToQuotationSent(
                context: context,
                task: task,
                status: StatusType.ordered.status.name,
              ),
        );

      case StatusType.ordered:
        return ReviewWidgetTile(
          title: "Invoice Approval Required",
          subtitle: "Task ${task.dealNo} materials were ordered",
          btnText: "Accept Invoice",
          onTap:
              () => context.updateTaskStatusToQuotationSent(
                context: context,
                task: task,
              ),
          child:
              isAdmin
                  ? ActionButton(
                    label: "Reject Invoice",
                    backgroundColor: Colors.redAccent,
                    fontColor: Colors.white,
                    onPress:
                        () => context.updateTaskStatusToQuotationSent(
                          context: context,
                          task: task,
                          status: StatusType.invoiceRejected.status.name,
                        ),
                  )
                  : null,
        );

      case StatusType.invoiceApproved:
        return ReviewWidgetTile(
          title: "Send Bill",
          subtitle: "Task ${task.dealNo} ready for billing",
          btnText: "Send Bill",
          onTap:
              () => context.updateTaskStatusToQuotationSent(
                context: context,
                task: task,
              ),
          child:
              !isAgency
                  ? ActionButton(
                    label: "View Bill",
                    backgroundColor: Colors.white,
                    fontColor: Colors.black,
                    onPress:
                        () => context.push(AppRoutes.reviewBill, extra: task),
                  )
                  : null,
        );

      default:
        return Text(status.name);
    }
  }
}

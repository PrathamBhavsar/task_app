import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/args.dart';
import '../../../../domain/entities/task.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/enums/status_type.dart';
import '../../../../utils/extensions/status_type_extractor.dart';
import 'review_widget_tile.dart';

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({required this.task, super.key});

  final Task task;

  @override
  Widget build(BuildContext context) {
    final status = task.status.toStatusType();

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
              "Task ${task.dealNo} from ${task.createdBy.name} requires measurements",
          btnText: "Add Measurement",
          onTap:
              () => context.push(
                AppRoutes.measurement,
                extra: MeasurementArgs(task: task),
              ),
        );

      case StatusType.quotationSent:
        return ReviewWidgetTile(
          title: "Quotation Approval Required",
          subtitle:
              "Task ${task.dealNo} from ${task.createdBy.name} requires quotation approval",
          btnText: "Review Quotation",
          onTap: () => context.push(AppRoutes.editQuote, extra: task),
        );

      default:
        return Text(status?.name ?? "NONE");
    }
  }
}

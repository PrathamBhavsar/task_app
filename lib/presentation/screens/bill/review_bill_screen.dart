import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/di/di.dart';
import '../../../core/helpers/cache_helper.dart';
import '../../../domain/entities/bill.dart';
import '../../../domain/entities/service.dart';
import '../../../domain/entities/task.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/enums/status_type.dart';
import '../../../utils/extensions/date_formatter.dart';
import '../../../utils/extensions/padding.dart';
import '../../../utils/extensions/update_task_status.dart';
import '../../blocs/bill/bill_bloc.dart';
import '../../blocs/bill/bill_state.dart';
import '../../blocs/measurement/api/measurement_api_bloc.dart';
import '../../blocs/measurement/api/measurement_api_event.dart';
import '../../blocs/measurement/api/service_api_bloc.dart';
import '../../blocs/measurement/api/service_api_event.dart';
import '../../blocs/measurement/api/service_api_state.dart';
import '../../widgets/action_button.dart';
import '../../widgets/bordered_container.dart';
import '../../widgets/custom_tag.dart';
import '../../widgets/tile_row.dart';
import '../quote/widgets/service_tile.dart';

TextStyle textStyle = AppTexts.labelTextStyle.copyWith(fontSize: 14.sp);

class ReviewBillScreen extends StatefulWidget {
  const ReviewBillScreen({required this.task, super.key});

  final Task task;

  @override
  State<ReviewBillScreen> createState() => _ReviewBillScreenState();
}

class _ReviewBillScreenState extends State<ReviewBillScreen> {
  @override
  void initState() {
    context.read<ServiceApiBloc>().add(
      FetchServicesRequested(widget.task.taskId!),
    );

    context.read<MeasurementApiBloc>().add(
      FetchMeasurementsRequested(widget.task.taskId!),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Review Agency Bill', style: AppTexts.titleTextStyle),
          ],
        ),
      ),
      body: BlocBuilder<BillBloc, BillState>(
        builder: (context, billState) {
          return BlocBuilder<ServiceApiBloc, ServiceApiState>(
            builder: (context, serviceState) {
              final isLoading =
                  billState is BillInitial ||
                  billState is BillLoadInProgress ||
                  serviceState is ServiceInitial ||
                  serviceState is ServiceLoadInProgress;

              if (isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (billState is BillLoadFailure) {
                return const Center(
                  child: Text('There was an issue loading bills!'),
                );
              }

              if (billState is BillLoadSuccess &&
                  serviceState is ServiceLoadSuccess) {
                final Bill bill = billState.bills.firstWhere(
                  (b) => b.taskId == widget.task.taskId,
                  orElse: () => throw Exception('Bill not found'),
                );

                final services = serviceState.services;

                return SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Review and approve or reject the bill from ${widget.task.agency!.name}',
                          style: AppTexts.inputHintTextStyle,
                        ),
                        20.hGap,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Bill Details',
                              style: AppTexts.labelTextStyle,
                            ),
                            CustomTag(
                              text: bill.status.name,
                              color: Colors.white12,
                            ),
                          ],
                        ),
                        10.hGap,
                        TileRow(
                          key1: 'Bill Number',
                          value1: 'BILL-123456',
                          key2: 'Created At',
                          value2: bill.createdAt.toPrettyDate(),
                        ),
                        10.hGap,
                        TileRow(
                          key1: 'Due Date',
                          value1: bill.dueDate.toPrettyDate(),
                          key2: 'Total Amount',
                          value2: "₹${bill.total}",
                        ),
                        20.hGap,
                        Text('Service Charges', style: AppTexts.labelTextStyle),
                        10.hGap,
                        _buildServiceCharges(services, bill),
                        20.hGap,

                        getIt<CacheHelper>().isAdmin
                            ? ActionButton(
                              label: 'Mark as Paid',
                              onPress: () {
                                context.updateTaskStatus(
                                  task: widget.task,
                                  status: StatusType.billPaid.status.name,
                                  context: context,
                                );
                              },
                              backgroundColor: Colors.black,
                              fontColor: Colors.white,
                            )
                            : SizedBox.shrink(),
                      ],
                    ).padAll(AppPaddings.appPaddingInt),
                  ),
                );
              }
              return const Center(child: Text("Issue loading bill"));
            },
          );
        },
      ),
    );
  }

  BorderedContainer _buildServiceCharges(List<Service> services, Bill bill) {
    return BorderedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: services.length,
            separatorBuilder:
                (context, index) => const Divider(color: AppColors.accent),
            itemBuilder: (context, index) {
              final service = services[index];
              return QuoteServiceTile(service: service, textStyle: textStyle);
            },
          ),
          Divider(color: AppColors.accent).padSymmetric(vertical: 5.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Subtotal', style: AppTexts.inputHintTextStyle),
              Text(
                "₹${bill.subtotal}",
                style: AppTexts.inputTextStyle.copyWith(
                  fontVariations: [FontVariation.weight(700)],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Tax(7%)', style: AppTexts.inputHintTextStyle),
              Text(
                "₹${bill.tax}",
                style: AppTexts.inputTextStyle.copyWith(
                  fontVariations: [FontVariation.weight(700)],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total', style: AppTexts.inputTextStyle),
              Text(
                "₹${bill.total}",
                style: AppTexts.inputTextStyle.copyWith(
                  fontVariations: [FontVariation.weight(700)],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/quote_measurement.dart';
import '../../../domain/entities/service.dart';
import '../../../domain/entities/task.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/enums/status_type.dart';
import '../../../utils/extensions/date_formatter.dart';
import '../../../utils/extensions/padding.dart';
import '../../../utils/extensions/update_task_status.dart';
import '../../blocs/measurement/api/measurement_api_bloc.dart';
import '../../blocs/measurement/api/measurement_api_event.dart';
import '../../blocs/measurement/api/measurement_api_state.dart';
import '../../blocs/measurement/api/service_api_bloc.dart';
import '../../blocs/measurement/api/service_api_event.dart';
import '../../blocs/measurement/api/service_api_state.dart';
import '../../blocs/quote/cubits/quote_cubit.dart';
import '../../blocs/quote/cubits/quote_cubit_state.dart';
import '../../blocs/quote/quote_api_bloc.dart';
import '../../blocs/quote/quote_api_event.dart';
import '../../blocs/quote/quote_api_state.dart';
import '../../blocs/quote_measurements/quote_measurement_bloc.dart';
import '../../blocs/quote_measurements/quote_measurement_event.dart';
import '../../blocs/quote_measurements/quote_measurement_state.dart';
import '../../blocs/task/task_bloc.dart';
import '../../blocs/task/task_state.dart';
import '../../widgets/action_button.dart';
import '../../widgets/bordered_container.dart';
import '../../widgets/custom_tag.dart';
import '../../widgets/tile_row.dart';
import 'widgets/product_tile.dart';
import 'widgets/service_tile.dart';

TextStyle textStyle = AppTexts.labelTextStyle.copyWith(fontSize: 14.sp);

class QuoteDetailsScreen extends StatefulWidget {
  const QuoteDetailsScreen({required this.task, super.key});

  final Task task;

  @override
  State<QuoteDetailsScreen> createState() => _QuoteDetailsScreenState();
}

class _QuoteDetailsScreenState extends State<QuoteDetailsScreen> {
  bool _initialized = false;

  @override
  void initState() {
    context.read<MeasurementApiBloc>().add(
      FetchMeasurementsRequested(widget.task.taskId!),
    );
    context.read<ServiceApiBloc>().add(
      FetchServicesRequested(widget.task.taskId!),
    );
    context.read<QuoteApiBloc>().add(FetchQuotesRequested(widget.task.taskId!));

    context.read<QuoteMeasurementBloc>().add(
      FetchQuoteMeasurementsRequested(widget.task.taskId!),
    );
    super.initState();
  }

  void _tryInitializeCubit(BuildContext context) {
    if (_initialized) {
      return;
    }

    final mState = context.read<MeasurementApiBloc>().state;
    final sState = context.read<ServiceApiBloc>().state;
    final qmState = context.read<QuoteMeasurementBloc>().state;

    if (mState is MeasurementLoadSuccess &&
        sState is ServiceLoadSuccess &&
        qmState is QuoteMeasurementLoadSuccess) {
      final task = widget.task;
      final measurements = mState.measurements;
      final services = sState.services;
      final quoteMeasurements = qmState.quoteMeasurements;

      context.read<QuoteCubit>().initialize(
        task,
        services,
        measurements,
        quoteMeasurements,
      );

      _initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text(widget.task.name, style: AppTexts.titleTextStyle)],
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<QuoteApiBloc, QuoteApiState>(
            listener: (context, state) {
              if (state is QuoteApiLoaded) {
                context.read<QuoteCubit>().setQuote(state.quote);
              }
            },
          ),
          BlocListener<MeasurementApiBloc, MeasurementApiState>(
            listener: (context, state) {
              _tryInitializeCubit(context);
            },
          ),
          BlocListener<QuoteMeasurementBloc, QuoteMeasurementState>(
            listener: (context, state) {
              _tryInitializeCubit(context);
            },
          ),
          BlocListener<ServiceApiBloc, ServiceApiState>(
            listener: (context, state) {
              _tryInitializeCubit(context);
            },
          ),
          BlocListener<TaskBloc, TaskState>(
            listener: (context, state) {
              if (state is UpdateTaskStatusSuccess) {
                context.go(AppRoutes.home);
              }
            },
          ),
        ],
        child: BlocBuilder<QuoteCubit, QuoteCubitState>(
          builder: (context, state) {
            final quote = state.quote;
            final quoteMeasurementList = state.quoteMeasurements;
            final serviceList = state.services;

            if (quote == null || quoteMeasurementList.isEmpty) {
              return Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Review and approve or reject the bill from the agency',
                    style: AppTexts.inputHintTextStyle,
                  ),
                  20.hGap,
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
                            CustomTag(
                              text: 'Pending Approval',
                              color: Colors.black26,
                            ),
                          ],
                        ),
                        20.hGap,
                        TileRow(
                          key1: 'Created At',
                          value1: quote.createdAt.toPrettyDate(),
                          key2: 'Expiry Date',
                          value2: widget.task.dueDate.toPrettyDate(),
                        ),
                        10.hGap,
                        TileRow(
                          key1: 'Created By',
                          value1: widget.task.createdBy.name,
                          key2: 'Total Amount',
                          value2: "₹${quote.total.toStringAsFixed(2)}",
                        ),
                      ],
                    ),
                  ),
                  20.hGap,
                  Text('Quote Items', style: AppTexts.labelTextStyle),
                  20.hGap,
                  BorderedContainer(
                    child: Column(
                      children: [
                        _buildQuote(
                          quoteMeasurementList,
                          state.productSubtotal,
                        ),
                        30.hGap,
                        _buildAgencyServices(
                          serviceList,
                          state.serviceSubtotal,
                        ),
                        30.hGap,
                        Container(
                          padding: EdgeInsets.all(AppPaddings.appPaddingInt),
                          decoration: BoxDecoration(
                            color: AppColors.lighterGreenBg,
                            borderRadius: AppBorders.radius,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Agency Cost:',
                                    style: AppTexts.inputHintTextStyle.copyWith(
                                      color: AppColors.darkGreenText,
                                    ),
                                  ),
                                  Text(
                                    '\$240.00',
                                    style: AppTexts.inputTextStyle.copyWith(
                                      fontVariations: [
                                        FontVariation.weight(700),
                                      ],
                                      color: AppColors.darkGreenText,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Agency Service Profit:',
                                    style: AppTexts.inputHintTextStyle.copyWith(
                                      color: AppColors.darkGreenText,
                                    ),
                                  ),
                                  Text(
                                    '43.75%',
                                    style: AppTexts.inputTextStyle.copyWith(
                                      fontVariations: [
                                        FontVariation.weight(700),
                                      ],
                                      color: AppColors.darkGreenText,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  10.hGap,
                  Text('Note', style: AppTexts.labelTextStyle),
                  Text(
                    'Quote valid for 15 days. Installation will be scheduled within 2 weeks of order confirmation.',
                    style: AppTexts.inputLabelTextStyle,
                  ),
                  20.hGap,
                  BorderedContainer(
                    child: Column(
                      spacing: 10.h,
                      children: [
                        ActionButton(
                          label: 'Download PDF',
                          onPress: () {},
                          backgroundColor: Colors.white,
                          fontColor: Colors.black,
                          hasBorder: true,
                        ),
                        ActionButton(
                          label: 'Email to Customer',
                          onPress: () {},
                          backgroundColor: Colors.white,
                          fontColor: Colors.black,
                          hasBorder: true,
                        ),
                        ActionButton(
                          label: 'Mark as Approved',
                          onPress: () {
                            context.updateTaskStatusToQuotationSent(
                              task: widget.task,
                              context: context,
                            );
                          },
                          backgroundColor: Colors.black,
                          fontColor: Colors.white,
                        ),
                        ActionButton(
                          label: 'Mark as Rejected',
                          onPress: () {
                            context.updateTaskStatusToQuotationSent(
                              status: StatusType.quotationRejected.name,
                              task: widget.task,
                              context: context,
                            );
                          },
                          fontColor: Colors.white,
                          backgroundColor: Colors.red,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ).padAll(AppPaddings.appPaddingInt),
    );
  }

  Column _buildQuote(
    List<QuoteMeasurement> quoteMeasurements,
    double? productSubtotal,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Products',
          style: AppTexts.inputLabelTextStyle.copyWith(
            fontVariations: [FontVariation.weight(800)],
          ),
        ),
        10.hGap,
        ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ProductTile(
              qm: quoteMeasurements[index],
              textStyle: textStyle,
            );
          },
          separatorBuilder:
              (context, index) => const Divider(color: AppColors.accent),
          itemCount: quoteMeasurements.length,
        ),

        Divider(color: AppColors.accent),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Products Subtotal', style: AppTexts.inputTextStyle),
            Text(
              "₹${productSubtotal?.toStringAsFixed(2)}",
              style: AppTexts.inputTextStyle.copyWith(
                fontVariations: [FontVariation.weight(700)],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column _buildAgencyServices(
    List<Service> services,
    double? servicesSubtotal,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Agency Services',
          style: AppTexts.inputLabelTextStyle.copyWith(
            fontVariations: [FontVariation.weight(800)],
          ),
        ),
        10.hGap,
        ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return QuoteServiceTile(
              service: services[index],
              textStyle: textStyle,
            );
          },
          separatorBuilder:
              (context, index) => const Divider(color: AppColors.accent),
          itemCount: services.length,
        ),

        Divider(color: AppColors.accent),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Services Subtotal', style: AppTexts.inputTextStyle),
            Text(
              "₹${servicesSubtotal?.toStringAsFixed(2)}",
              style: AppTexts.inputTextStyle.copyWith(
                fontVariations: [FontVariation.weight(700)],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

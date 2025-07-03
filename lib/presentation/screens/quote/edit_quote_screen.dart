import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../data/models/payloads/update_quote_payload.dart';
import '../../../domain/entities/task.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/extensions/padding.dart';
import '../../../utils/extensions/quote_measurement_converter.dart';
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
import '../../blocs/task/task_bloc.dart';
import '../../blocs/task/task_event.dart';
import '../../blocs/task/task_state.dart';
import '../../providers/measurement_provider.dart';
import '../../widgets/action_button.dart';
import '../../widgets/bordered_container.dart';
import '../../widgets/custom_tag.dart';
import '../../widgets/labeled_text_field.dart';
import '../../../domain/entities/quote_measurement.dart';
import 'widgets/quote_measurement_tile.dart';
import 'widgets/static_service_tile.dart';

class EditQuoteScreen extends StatefulWidget {
  const EditQuoteScreen({required this.task, super.key});

  final Task task;

  @override
  State<EditQuoteScreen> createState() => _EditQuoteScreenState();
}

class _EditQuoteScreenState extends State<EditQuoteScreen> {
  late TextEditingController overallDiscountController;
  late TextEditingController noteController;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    overallDiscountController = TextEditingController();
    noteController = TextEditingController();
    context.read<MeasurementApiBloc>().add(
      FetchMeasurementsRequested(widget.task.taskId!),
    );
    context.read<ServiceApiBloc>().add(
      FetchServicesRequested(widget.task.taskId!),
    );
    context.read<QuoteApiBloc>().add(FetchQuotesRequested(widget.task.taskId!));
  }

  void _tryInitializeCubit(BuildContext context) {
    if (_initialized) {
      return;
    }

    final mState = context.read<MeasurementApiBloc>().state;
    final sState = context.read<ServiceApiBloc>().state;

    if (mState is MeasurementLoadSuccess && sState is ServiceLoadSuccess) {
      final task = widget.task;
      final measurements = mState.measurements;
      final services = sState.services;

      context.read<QuoteCubit>().initializeEmpty(task, services, measurements);
      _initialized = true;
    }
  }

  @override
  void dispose() {
    overallDiscountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<QuoteApiBloc, QuoteApiState>(
          listener: (context, state) {
            if (state is QuoteApiLoaded) {
              context.read<QuoteCubit>().setQuote(state.quote);
            }
            if (state is QuoteApiUpdated) {
              context.updateTaskStatusToQuotationSent(
                task: widget.task,
                context: context,
              );

              context.pop();
            }
          },
        ),
        BlocListener<MeasurementApiBloc, MeasurementApiState>(
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
              context.read<TaskBloc>().add(FetchTasksRequested());
              context.pop();
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Edit Quote #1001', style: AppTexts.titleTextStyle),
            ],
          ),
        ),
        body: BlocBuilder<QuoteCubit, QuoteCubitState>(
          builder: (context, state) {
            final quote = state.quote;
            final quoteMeasurementList = state.quoteMeasurements;
            final serviceList = state.services;

            if (quote == null || quoteMeasurementList.isEmpty) {
              return Center(child: CircularProgressIndicator());
            }

            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildExpansionTile(
                      title: 'Product Quotes',
                      length: quoteMeasurementList.length,
                      widget: ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return QuoteMeasurementTile(
                            index: index,
                            quoteMeasurement: quoteMeasurementList[index],
                          );
                        },
                        separatorBuilder: (context, index) => 10.hGap,
                        itemCount: quoteMeasurementList.length,
                      ),
                      addLabel: 'Add Custom Product',
                      onAdd: () {},
                      isProduct: true,
                    ),
                    _buildExpansionTile(
                      title: 'Agency Service Charges',
                      length: serviceList.length,
                      widget: BorderedContainer(
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    "Service",
                                    softWrap: true,
                                    overflow: TextOverflow.visible,
                                    style: AppTexts.inputLabelTextStyle,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    "Qty",
                                    textAlign: TextAlign.center,
                                    style: AppTexts.inputLabelTextStyle,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    "Rate",
                                    textAlign: TextAlign.center,
                                    style: AppTexts.inputLabelTextStyle,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    "Amount",
                                    textAlign: TextAlign.right,
                                    style: AppTexts.inputLabelTextStyle,
                                  ),
                                ),
                              ],
                            ),
                            Divider(color: AppColors.accent),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return StaticServiceTile(
                                  service: serviceList[index],
                                );
                              },
                              separatorBuilder: (context, index) => 10.hGap,
                              itemCount: quoteMeasurementList.length,
                            ),
                          ],
                        ),
                      ),
                      addLabel: 'Add Custom Service',
                      onAdd: () {},
                      isService: true,
                    ),
                    10.hGap,
                    BorderedContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            spacing: 3.h,
                            children: [
                              _buildTotalRow(
                                'Subtotal',
                                quote.subtotal,
                                labelTextStyle: AppTexts.inputHintTextStyle
                                    .copyWith(
                                      fontVariations: [
                                        FontVariation.weight(700),
                                      ],
                                    ),
                                valueTextStyle: AppTexts.inputTextStyle
                                    .copyWith(
                                      fontVariations: [
                                        FontVariation.weight(700),
                                      ],
                                    ),
                              ),
                              _buildTotalRow('Tax (7%)', quote.tax),
                              _buildTotalRow(
                                'Total',
                                quote.total,
                                labelTextStyle: AppTexts.inputTextStyle
                                    .copyWith(
                                      fontVariations: [
                                        FontVariation.weight(700),
                                      ],
                                    ),
                                valueTextStyle: AppTexts.inputTextStyle
                                    .copyWith(
                                      fontVariations: [
                                        FontVariation.weight(700),
                                      ],
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    10.hGap,
                    LabeledTextInput(
                      title: 'Notes',
                      hint: 'Enter notes here',
                      isMultiline: true,
                      controller: noteController,
                    ),
                    ActionButton(
                      label: 'Save Quote',
                      onPress: () => _onSubmit(context, quoteMeasurementList),
                      backgroundColor: Colors.black,
                      fontColor: Colors.white,
                    ),
                    10.hGap,
                    ActionButton(label: 'Cancel', onPress: () {}),
                  ],
                ).padAll(AppPaddings.appPaddingInt),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onSubmit(
    BuildContext context,
    List<QuoteMeasurement> quoteMeasurementList,
  ) {
    final quote = context.read<QuoteCubit>().state.quote!;
    final taskId = context.read<QuoteCubit>().state.task!.taskId!;

    context.read<QuoteApiBloc>().add(
      UpdateQuoteRequested(
        UpdateQuotePayload(
          quoteId: quote.quoteId,
          taskId: taskId,
          subtotal: quote.subtotal,
          tax: quote.tax,
          total: quote.total,
          notes: noteController.text,
        ),
      ),
    );

    context.read<QuoteApiBloc>().add(
      UpdateQuoteMeasurementsRequested(
        quoteMeasurementList.map((e) => e.toUpdatePayload()).toList(),
      ),
    );
  }

  Row _buildTotalRow(
    String title,
    double amount, {
    TextStyle? labelTextStyle,
    TextStyle? valueTextStyle,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: labelTextStyle ?? AppTexts.inputHintTextStyle),
        Text(
          '₹${amount.toStringAsFixed(2)}',
          style: valueTextStyle ?? AppTexts.inputTextStyle,
        ),
      ],
    );
  }

  ExpansionTile _buildExpansionTile({
    required String title,
    required int length,
    required Widget widget,
    required String addLabel,
    required Function() onAdd,
    bool isService = false,
    bool isProduct = false,
    bool isAdditional = false,
  }) {
    return ExpansionTile(
      showTrailingIcon: true,
      collapsedShape: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.accent),
      ),
      trailing: CustomTag(
        text: length.toString(),
        color: Colors.black,
        fontColor: Colors.white,
      ),
      shape: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.accent),
      ),
      title: Text(
        title,
        style: AppTexts.labelTextStyle.copyWith(
          fontSize: 18.sp,
          decoration: TextDecoration.underline,
        ),
      ),
      enabled: true,
      children: [
        if (!isAdditional) ...[
          BorderedContainer(
            color: isProduct ? AppColors.blueBg : AppColors.bgYellow,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isProduct ? 'Measurement-Based Products' : 'Agency Services',
                  style: AppTexts.inputTextStyle.copyWith(
                    fontVariations: [FontVariation.weight(700)],
                    overflow: TextOverflow.ellipsis,
                    color:
                        isProduct
                            ? AppColors.darkBlueText
                            : AppColors.darkYellowText,
                  ),
                ),
                5.hGap,
                Text(
                  isProduct
                      ? 'These products are based on the measurements provided by the agency. You can add rates, modify quantities, and apply discounts.'
                      : 'These are service charges from the agency. You can modify quantities, rates, and apply discounts. The store pays the agency at the store rate, while customers are quoted at the customer rate.',
                  style: AppTexts.inputTextStyle.copyWith(
                    color:
                        isProduct
                            ? AppColors.darkBlueText
                            : AppColors.darkYellowText,
                  ),
                ),
              ],
            ),
          ),
          5.hGap,
        ],
        widget,
        10.hGap,
        if (isService) ...[
          BorderedContainer(
            color: AppColors.lighterGreenBg,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Agency Service Profit',
                  style: AppTexts.inputTextStyle.copyWith(
                    fontVariations: [FontVariation.weight(700)],
                    color: AppColors.darkGreenText,
                  ),
                ),
                5.hGap,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Agency Cost:',
                      style: AppTexts.inputHintTextStyle.copyWith(
                        color: AppColors.darkGreenText,
                      ),
                    ),
                    Text(
                      '₹240.00',
                      style: AppTexts.inputTextStyle.copyWith(
                        fontVariations: [FontVariation.weight(700)],
                        color: AppColors.darkGreenText,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Profit margin:',
                      style: AppTexts.inputHintTextStyle.copyWith(
                        color: AppColors.darkGreenText,
                      ),
                    ),
                    Text(
                      '43.75%',
                      style: AppTexts.inputTextStyle.copyWith(
                        fontVariations: [FontVariation.weight(700)],
                        color: AppColors.darkGreenText,
                      ),
                    ),
                  ],
                ),
                10.hGap,
                ActionButton(label: 'View Rate Card', onPress: () {}),
              ],
            ),
          ),
          10.hGap,
        ],
      ],
    );
  }

  Padding buildServiceTile(int index, MeasurementProvider provider) {
    return Padding(
      padding: index == 0 ? EdgeInsets.zero : EdgeInsets.only(top: 10.h),
      child: BorderedContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('#${index + 1}', style: AppTexts.titleTextStyle),
                IconButton(
                  onPressed: () => provider.removeServiceAt(index),
                  icon: Icon(
                    Icons.delete_outline_rounded,
                    color: AppColors.errorRed,
                  ),
                ),
              ],
            ),
            10.hGap,
            LabeledTextInput(title: 'Service Type', hint: 'Enter service type'),
            Row(
              children: [
                Expanded(child: LabeledTextInput(title: 'Quantity', hint: '0')),
                10.wGap,
                Expanded(child: LabeledTextInput(title: 'Rate', hint: '0.00')),
                10.wGap,
                Expanded(
                  child: LabeledTextInput(title: 'Amount', hint: '0.00'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../domain/entities/quote.dart';
import '../../../domain/entities/task.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/extensions/padding.dart';
import '../../blocs/measurement/api/measurement_api_bloc.dart';
import '../../blocs/measurement/api/measurement_api_event.dart';
import '../../blocs/measurement/api/measurement_api_state.dart';
import '../../blocs/measurement/api/service_api_bloc.dart';
import '../../blocs/measurement/api/service_api_event.dart';
import '../../blocs/measurement/api/service_api_state.dart';
import '../../blocs/quote/quote_bloc.dart';
import '../../blocs/quote/quote_event.dart';
import '../../blocs/quote/quote_state.dart';
import '../../providers/measurement_provider.dart';
import '../../widgets/action_button.dart';
import '../../widgets/bordered_container.dart';
import '../../widgets/custom_tag.dart';
import '../../widgets/labeled_text_field.dart';
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
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    overallDiscountController = TextEditingController();
    context.read<MeasurementApiBloc>().add(
      FetchMeasurementsRequested(widget.task.taskId!),
    );
    context.read<ServiceApiBloc>().add(
      FetchServicesRequested(widget.task.taskId!),
    );
    context.read<QuoteBloc>().add(FetchQuotesRequested(widget.task.taskId!));
  }

  void _tryInitializeQuotes(BuildContext context) {
    if (_initialized) {
      return;
    }

    final measurementState = context.read<MeasurementApiBloc>().state;
    final serviceState = context.read<ServiceApiBloc>().state;

    if (measurementState is MeasurementLoadSuccess &&
        serviceState is ServiceLoadSuccess) {
      _initialized = true;

      context.read<QuoteBloc>().add(
        InitializeQuotes(
          widget.task,
          measurementState.measurements,
          serviceState.services,
        ),
      );
    }
  }

  @override
  void dispose() {
    overallDiscountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _tryInitializeQuotes(context);
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text('Edit Quote #1001', style: AppTexts.titleTextStyle)],
        ),
      ),
      body: BlocBuilder<QuoteBloc, QuoteState>(
        builder: (context, quoteState) {
          if (quoteState is QuoteLoadSuccess) {
            final Quote? quote = quoteState.quote;
            final serviceList = quoteState.services;
            final quoteMeasurementList = quoteState.quoteMeasurements;

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
                          // LabeledTextInput(
                          //   title: 'Overall Discount %',
                          //   hint: '0.00',
                          //   controller: overallDiscountController,
                          //   keyboardType: TextInputType.number,
                          //   onChanged: (value) {
                          //     final overallDiscount = double.tryParse(value);
                          //     context.read<QuoteBloc>().add(
                          //       QuoteUpdated(discount: overallDiscount),
                          //     );
                          //   },
                          // ),
                          // Divider(color: AppColors.accent),
                          Column(
                            spacing: 3.h,
                            children: [
                              // _buildTotalRow('Products Subtotal', 952),
                              // _buildTotalRow('Services Subtotal', 345),
                              // _buildTotalRow('Additional Items Subtotal', 150),
                              _buildTotalRow(
                                'Subtotal',
                                quote?.subtotal ?? 0,
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
                              _buildTotalRow('Tax (7%)', quote?.tax ?? 0),
                              _buildTotalRow(
                                'Total',
                                quote?.total ?? 0,
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
                    ),
                    ActionButton(
                      label: 'Save Quote',
                      onPress: () {},
                      backgroundColor: Colors.black,
                      fontColor: Colors.white,
                    ),
                    10.hGap,
                    ActionButton(label: 'Cancel', onPress: () {}),
                  ],
                ).padAll(AppPaddings.appPaddingInt),
              ),
            );
          }
          return Center(child: Text("Error loading quote"));
        },
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
        // ...List.generate(length, (index) => tile),
        10.hGap,
        ActionButton(label: addLabel, prefixIcon: Icons.add, onPress: onAdd),
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

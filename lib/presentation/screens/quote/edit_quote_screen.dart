import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/measurement.dart';
import '../../../domain/entities/service.dart';
import '../../../domain/entities/task.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/extensions/padding.dart';
import '../../blocs/measurement/api/measurement_api_bloc.dart';
import '../../blocs/measurement/api/measurement_api_event.dart';
import '../../blocs/measurement/api/measurement_api_state.dart';
import '../../blocs/measurement/api/service_api_bloc.dart';
import '../../blocs/measurement/api/service_api_event.dart';
import '../../blocs/measurement/api/service_api_state.dart';
import '../../blocs/measurement/measurement_bloc.dart';
import '../../blocs/measurement/measurement_event.dart';
import '../../blocs/quote/quote_bloc.dart';
import '../../blocs/quote/quote_event.dart';
import '../../blocs/quote/quote_state.dart';
import '../../providers/measurement_provider.dart';
import '../../widgets/action_button.dart';
import '../../widgets/bordered_container.dart';
import '../../widgets/custom_tag.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/labeled_text_field.dart';

class EditQuoteScreen extends StatefulWidget {
  const EditQuoteScreen({required this.task, super.key});

  final Task task;

  @override
  State<EditQuoteScreen> createState() => _EditQuoteScreenState();
}

class _EditQuoteScreenState extends State<EditQuoteScreen> {
  @override
  void initState() {
    context.read<MeasurementApiBloc>().add(
      FetchMeasurementsRequested(widget.task.taskId!),
    );
    context.read<ServiceApiBloc>().add(
      FetchServicesRequested(widget.task.taskId!),
    );
    context.read<QuoteBloc>().add(FetchQuotesRequested(widget.task.taskId!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text('Edit Quote #1001', style: AppTexts.titleTextStyle)],
        ),
      ),
      body: BlocConsumer<QuoteBloc, QuoteState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is QuoteLoadInProgress) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.black,
                backgroundColor: Colors.white,
              ),
            );
          }

          if (state is QuoteLoadSuccess) {
            final serviceState = context.read<ServiceApiBloc>().state;
            final measurementState = context.read<MeasurementApiBloc>().state;
            final List<Service> serviceList =
                serviceState is ServiceLoadSuccess ? serviceState.services : [];

            final List<Measurement> measurementList =
                measurementState is MeasurementLoadSuccess
                    ? measurementState.measurements
                    : [];

            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildExpansionTile(
                      title: 'Product Quotes',
                      length: measurementList.length,
                      tile: _buildTile(
                        'Description',
                        measurementList.length,
                        // provider,
                      ),
                      addLabel: 'Add Custom Product',
                      // () => provider.addMeasurement(),
                      onAdd: () {},
                      isProduct: true,
                    ),
                    _buildExpansionTile(
                      title: 'Agency Service Charges',
                      // provider.services.length,
                      length: serviceList.length,
                      tile: _buildTile(
                        'Service',
                        // provider.services.length,
                        serviceList.length,
                        // provider,
                        isService: true,
                      ),
                      addLabel: 'Add Custom Service',
                      // () => provider.addService(),
                      onAdd: () {},
                      isService: true,
                    ),
                    _buildExpansionTile(
                      title: 'Additional Items',
                      // provider.additionalItems.length,
                      length: 1,

                      tile: _buildTile(
                        'Description',
                        // provider.additionalItems.length,
                        1,
                        // provider,
                      ),
                      addLabel: 'Add Additional Item',
                      // () => provider.addAdditionalItems(),
                      onAdd: () {},
                      isAdditional: true,
                    ),
                    10.hGap,
                    BorderedContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LabeledTextInput(
                            title: 'Overall Discount %',
                            hint: '0.00',
                          ),
                          Divider(color: AppColors.accent),
                          Column(
                            spacing: 3.h,
                            children: [
                              // _buildTotalRow('Products Subtotal', 952),
                              // _buildTotalRow('Services Subtotal', 345),
                              // _buildTotalRow('Additional Items Subtotal', 150),
                              _buildTotalRow(
                                'Subtotal',
                                state.quote.subtotal,
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
                              _buildTotalRow('Tax (7%)', state.quote.tax),
                              _buildTotalRow(
                                'Total',
                                state.quote.total,
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
    required Widget tile,
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
      trailing: CustomTag(text: length.toString(), color: Colors.black, fontColor: Colors.white),
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
        ...List.generate(length, (index) => tile),
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

  Padding _buildTile(String title, int index, {bool isService = false}) {
    return Padding(
      padding: index == 0 ? EdgeInsets.zero : EdgeInsets.only(top: 10.h),
      child: BorderedContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LabeledTextInput(
              title: title,
              hint: 'Enter measurement description',
            ),
            Row(
              children: [
                Expanded(child: LabeledTextInput(title: 'Quantity', hint: '1')),
                10.wGap,
                Expanded(child: LabeledTextInput(title: 'Rate', hint: '0.00')),
                10.wGap,
                Expanded(
                  child: LabeledTextInput(title: 'Discount %', hint: '0.00'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total: ₹350.00', style: AppTexts.labelTextStyle),
                IconButton(
                  // onPressed: () => provider.removeMeasurementAt(index),
                  onPressed: () {},
                  icon: Icon(
                    Icons.delete_outline_rounded,
                    color: AppColors.errorRed,
                  ),
                ),
              ],
            ),
            if (isService) ...[
              Text(
                'Store pays: ₹35.00 per unit',
                style: AppTexts.inputHintTextStyle,
              ),
              Text(
                'Customer rate: ₹50.00 per unit',
                style: AppTexts.inputHintTextStyle,
              ),
            ],
          ],
        ),
      ),
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

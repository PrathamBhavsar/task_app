import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants/app_constants.dart';
import '../../../utils/extensions/padding.dart';
import '../../providers/measurement_provider.dart';
import '../../widgets/action_button.dart';
import '../../widgets/bordered_container.dart';
import '../../widgets/custom_tag.dart';
import '../../widgets/custom_text_field.dart';

class EditQuoteScreen extends StatelessWidget {
  const EditQuoteScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      forceMaterialTransparency: true,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text('Edit Quote #1001', style: AppTexts.titleTextStyle)],
      ),
    ),
    body: SafeArea(
      child: Consumer<MeasurementProvider>(
        builder:
            (
              BuildContext context,
              MeasurementProvider provider,
              Widget? child,
            ) => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildExpansionTile(
                    'Product Quotes',
                    provider.measurements.length,
                    _buildTile(
                      'Description',
                      provider.measurements.length,
                      provider,
                    ),
                    'Add Custom Product',
                    () => provider.addMeasurement(),
                    isProduct: true,
                  ),
                  _buildExpansionTile(
                    'Agency Service Charges',
                    provider.services.length,
                    _buildTile(
                      'Service',
                      provider.services.length,
                      provider,
                      isService: true,
                    ),
                    'Add Custom Service',
                    () => provider.addService(),
                    isService: true,
                  ),
                  _buildExpansionTile(
                    'Additional Items',
                    provider.additionalItems.length,
                    _buildTile(
                      'Description',
                      provider.additionalItems.length,
                      provider,
                    ),
                    'Add Additional Item',
                    () => provider.addAdditionalItems(),
                    isAdditional: true,
                  ),
                  10.hGap,
                  BorderedContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTextInput('Overall Discount %', '0.00'),
                        Divider(color: AppColors.accent),
                        Column(
                          spacing: 3.h,
                          children: [
                            _buildTotalRow('Products Subtotal', 952),
                            _buildTotalRow('Services Subtotal', 345),
                            _buildTotalRow('Additional Items Subtotal', 150),
                            _buildTotalRow(
                              'Subtotal',
                              1447,
                              labelTextStyle: AppTexts.inputHintTextStyle
                                  .copyWith(
                                    fontVariations: [FontVariation.weight(700)],
                                  ),
                              valueTextStyle: AppTexts.inputTextStyle.copyWith(
                                fontVariations: [FontVariation.weight(700)],
                              ),
                            ),
                            _buildTotalRow('Tax (7%)', 101.29),
                            _buildTotalRow(
                              'Total',
                              1548,
                              labelTextStyle: AppTexts.inputTextStyle.copyWith(
                                fontVariations: [FontVariation.weight(700)],
                              ),
                              valueTextStyle: AppTexts.inputTextStyle.copyWith(
                                fontVariations: [FontVariation.weight(700)],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  10.hGap,
                  _buildTextInput(
                    'Notes',
                    'Enter notes here',
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
      ),
    ),
  );

  Row _buildTotalRow(
    String title,
    double amount, {
    TextStyle? labelTextStyle,
    TextStyle? valueTextStyle,
  }) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title, style: labelTextStyle ?? AppTexts.inputHintTextStyle),
      Text(
        '\$${amount.toStringAsFixed(2)}',
        style: valueTextStyle ?? AppTexts.inputTextStyle,
      ),
    ],
  );

  ExpansionTile _buildExpansionTile(
    String title,
    int length,
    Widget tile,
    String addLabel,
    Function() onAdd, {
    bool isService = false,
    bool isProduct = false,
    bool isAdditional = false,
  }) => ExpansionTile(
    showTrailingIcon: true,
    collapsedShape: UnderlineInputBorder(
      borderSide: BorderSide(color: AppColors.accent),
    ),
    trailing: CustomTag(
      text: length.toString(),
      color: Colors.black,
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
                    '\$240.00',
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

  Padding _buildTile(
    String title,
    int index,
    MeasurementProvider provider, {
    bool isService = false,
  }) => Padding(
    padding: index == 0 ? EdgeInsets.zero : EdgeInsets.only(top: 10.h),
    child: BorderedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextInput(title, 'Enter measurement description'),
          Row(
            children: [
              Expanded(child: _buildTextInput('Quantity', '1')),
              10.wGap,
              Expanded(child: _buildTextInput('Rate', '0.00')),
              10.wGap,
              Expanded(child: _buildTextInput('Discount %', '0.00')),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total: \$350.00', style: AppTexts.labelTextStyle),
              IconButton(
                onPressed: () => provider.removeMeasurementAt(index),
                icon: Icon(
                  Icons.delete_outline_rounded,
                  color: AppColors.errorRed,
                ),
              ),
            ],
          ),
          if (isService) ...[
            Text(
              'Store pays: \$35.00 per unit',
              style: AppTexts.inputHintTextStyle,
            ),
            Text(
              'Customer rate: \$50.00 per unit',
              style: AppTexts.inputHintTextStyle,
            ),
          ],
        ],
      ),
    ),
  );

  Padding buildServiceTile(int index, MeasurementProvider provider) => Padding(
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
          _buildTextInput('Service Type', 'Enter service type'),
          Row(
            children: [
              Expanded(child: _buildTextInput('Quantity', '0')),
              10.wGap,
              Expanded(child: _buildTextInput('Rate', '0.00')),
              10.wGap,
              Expanded(child: _buildTextInput('Amount', '0.00')),
            ],
          ),
        ],
      ),
    ),
  );

  Widget _buildTextInput(
    String title,
    String hint, {
    bool isMultiline = false,
  }) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: AppTexts.labelTextStyle),
      10.hGap,
      CustomTextField(hintTxt: hint, isMultiline: isMultiline),
      10.hGap,
    ],
  );
}

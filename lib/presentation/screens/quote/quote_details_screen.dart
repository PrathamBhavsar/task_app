import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../data/models/quote.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/constants/custom_icons.dart';
import '../../../utils/extensions/padding.dart';
import '../../providers/measurement_provider.dart';
import '../../widgets/action_button.dart';
import '../../widgets/bordered_container.dart';
import '../../widgets/custom_tag.dart';
import '../../widgets/tile_row.dart';

TextStyle textStyle = AppTexts.labelTextStyle.copyWith(fontSize: 14.sp);

class QuoteDetailsScreen extends StatelessWidget {
  const QuoteDetailsScreen({super.key, required this.quote});

  final Quote quote;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      forceMaterialTransparency: true,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text(quote.name, style: AppTexts.titleTextStyle)],
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
                              quote.customer.name,
                              style: AppTexts.titleTextStyle.copyWith(
                                fontVariations: [FontVariation.weight(500)],
                              ),
                            ),
                            CustomTag(
                              text: 'Pending Approval',
                              color: Colors.black,
                              textColor: Colors.white,
                            ),
                          ],
                        ),
                        10.hGap,
                        IntrinsicWidth(
                          child: ActionButton(
                            label: 'Call',
                            prefixIcon: CustomIcon.phone,
                            onPress: () {},
                          ),
                        ),
                        10.hGap,
                        TileRow(
                          key1: 'Created At',
                          value1: quote.createdAt,
                          key2: 'Expiry Date',
                          value2: quote.dueDate,
                        ),
                        10.hGap,
                        TileRow(
                          key1: 'Created By',
                          value1: quote.createdBy,
                          key2: 'Total Amount',
                          value2: '\$336.00',
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
                        _buildQuote(),
                        30.hGap,
                        _buildAgencyServices(),
                        30.hGap,
                        _buildAdditionalItems(),
                        10.hGap,
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
                          label: 'Modify Quote Details',
                          onPress: () => context.pushNamed('editQuote'),
                          backgroundColor: Colors.black,
                          fontColor: Colors.white,
                        ),
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
                          onPress: () {},
                          backgroundColor: Colors.black,
                          fontColor: Colors.white,
                        ),
                        ActionButton(
                          label: 'Mark as Rejected',
                          onPress: () {},
                          fontColor: Colors.white,
                          backgroundColor: Colors.red,
                        ),
                      ],
                    ),
                  ),
                ],
              ).padAll(AppPaddings.appPaddingInt),
            ),
      ),
    ),
  );

  Column _buildQuote() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Products',
        style: AppTexts.inputLabelTextStyle.copyWith(
          fontVariations: [FontVariation.weight(800)],
        ),
      ),
      10.hGap,
      _buildProductRow('Living Room Window 1', '(72" × 48")', 1, 350, 350),
      _buildProductRow('Living Room Window 2', '(72" × 48")', 1, 350, 350),
      _buildProductRow('Master Bedroom Window 1', '(60" × 36")', 1, 280, 252),
      Divider(color: AppColors.accent),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Products Subtotal', style: AppTexts.inputTextStyle),
          Text(
            '\$952.00',
            style: AppTexts.inputTextStyle.copyWith(
              fontVariations: [FontVariation.weight(700)],
            ),
          ),
        ],
      ),
    ],
  );

  Column _buildAgencyServices() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Agency Services',
        style: AppTexts.inputLabelTextStyle.copyWith(
          fontVariations: [FontVariation.weight(800)],
        ),
      ),
      10.hGap,
      _buildBillRow('Curtain Stitching', 6, 45, 270),
      _buildBillRow('Track Fitting', 4, 50, 200),
      Divider(color: AppColors.accent),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Products Subtotal', style: AppTexts.inputTextStyle),
          Text(
            '\$952.00',
            style: AppTexts.inputTextStyle.copyWith(
              fontVariations: [FontVariation.weight(700)],
            ),
          ),
        ],
      ),
    ],
  );

  Column _buildAdditionalItems() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Additional Items',
        style: AppTexts.inputLabelTextStyle.copyWith(
          fontVariations: [FontVariation.weight(800)],
        ),
      ),
      10.hGap,
      _buildBillRow('Installation Service', 1, 150, 150),
      Divider(color: AppColors.accent),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Additional Items Subtotal', style: AppTexts.inputTextStyle),
          Text(
            '\$1,250.00',
            style: AppTexts.inputTextStyle.copyWith(
              fontVariations: [FontVariation.weight(700)],
            ),
          ),
        ],
      ),
      Divider(color: AppColors.accent).padSymmetric(vertical: 5.h),
      _buildTotalRow(
        'Subtotal',
        320,
        labelTextStyle: AppTexts.inputHintTextStyle.copyWith(
          fontVariations: [FontVariation.weight(700)],
        ),
        valueTextStyle: AppTexts.inputTextStyle.copyWith(
          fontVariations: [FontVariation.weight(700)],
        ),
      ),
      _buildTotalRow('Tax(5%)', 16),
      _buildTotalRow(
        'Total',
        336,
        labelTextStyle: AppTexts.inputTextStyle.copyWith(
          fontVariations: [FontVariation.weight(700)],
        ),
        valueTextStyle: AppTexts.inputTextStyle.copyWith(
          fontVariations: [FontVariation.weight(700)],
        ),
      ),
    ],
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

  Row _buildBillRow(title, int amount, int rate, int total) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(flex: 2, child: Text(title, style: textStyle)),
      Row(
        spacing: 25.w,
        children: [
          Text(amount.toString(), style: textStyle),
          Text('\$$rate.00', style: textStyle),
          Text('\$$total.00', style: textStyle),
        ],
      ),
    ],
  );

  Column _buildProductRow(
    String title,
    String product,
    int amount,
    int rate,
    int total,
  ) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: AppTexts.inputHintTextStyle),
      5.hGap,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(flex: 2, child: Text(product, style: textStyle)),
          Row(
            spacing: 30.w,
            children: [
              Text(amount.toString(), style: textStyle),
              Text('\$$rate.00', style: textStyle),
              Text('\$$total.00', style: textStyle),
            ],
          ),
        ],
      ),
      10.hGap,
    ],
  );
}

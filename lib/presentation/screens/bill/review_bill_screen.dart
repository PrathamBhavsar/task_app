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
import '../../widgets/tile_row.dart';

TextStyle textStyle = AppTexts.labelTextStyle.copyWith(fontSize: 14.sp);

class ReviewBillScreen extends StatelessWidget {
  const ReviewBillScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      forceMaterialTransparency: true,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text('Review Agency Bill', style: AppTexts.titleTextStyle)],
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Bill Details', style: AppTexts.labelTextStyle),
                      CustomTag(
                        text: 'Pending Approval',
                        color: Colors.black,
                        textColor: Colors.white,
                      ),
                    ],
                  ),

                  10.hGap,
                  TileRow(
                    key1: 'Bill Number',
                    value1: 'BILL-123456',
                    key2: 'Bill Number',
                    value2: 'Dec 14, 2023',
                  ),
                  10.hGap,
                  TileRow(
                    key1: 'Due Date',
                    value1: 'Dec 29, 2023',
                    key2: 'Total Amount',
                    value2: '\$336.00',
                  ),
                  20.hGap,
                  Text('Service Charges', style: AppTexts.labelTextStyle),
                  20.hGap,
                  BorderedContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildBillRow('Curtain Stitching', 6, 45, 270),
                        buildBillRow('Track Fitting', 4, 50, 200),
                        Divider(
                          color: AppColors.accent,
                        ).padSymmetric(vertical: 5.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Subtotal',
                              style: AppTexts.inputHintTextStyle,
                            ),
                            Text(
                              '\$320.00',
                              style: AppTexts.inputTextStyle.copyWith(
                                fontVariations: [FontVariation.weight(700)],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Tax(5%)', style: AppTexts.inputHintTextStyle),
                            Text(
                              '\$16.00',
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
                              '\$336.00',
                              style: AppTexts.inputTextStyle.copyWith(
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
                    'Enter note here',
                    isMultiline: true,
                  ),
                  20.hGap,
                  Row(
                    children: [
                      Expanded(
                        child: ActionButton(
                          label: 'Reject',
                          onPress: () {},
                          fontColor: Colors.white,
                          backgroundColor: Colors.red,
                        ),
                      ),
                      10.wGap,
                      Expanded(
                        child: ActionButton(
                          label: 'Approve',
                          onPress: () {},
                          backgroundColor: Colors.black,
                          fontColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ).padAll(AppPaddings.appPaddingInt),
            ),
      ),
    ),
  );

  Row buildBillRow(title, int amount, int rate, int total) => Row(
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

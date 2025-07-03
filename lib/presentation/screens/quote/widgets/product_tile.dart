import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../domain/entities/quote_measurement.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/extensions/padding.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({required this.qm, required this.textStyle, super.key});

  final QuoteMeasurement qm;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              qm.measurement.location,
              style: AppTexts.inputLabelTextStyle.copyWith(
                fontVariations: [FontVariation.weight(800)],
              ),
            ),
            Text(
              "(${qm.measurement.height} x ${qm.measurement.width})",
              style: AppTexts.inputLabelTextStyle.copyWith(
                fontVariations: [FontVariation.weight(800)],
              ),
            ),
          ],
        ),
        5.hGap,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Text("${qm.quantity} sqft", style: textStyle),
            ),
            Row(
              spacing: 60.w,
              children: [
                Text('₹${qm.rate} /sqft', style: textStyle),

                Text('-${qm.discount}%', style: textStyle),
              ],
            ),

          ],
        ),
        10.hGap,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              '₹${qm.totalPrice}',
              style: textStyle.copyWith(
                fontVariations: [FontVariation.weight(800)],
              ),
            ),
          ],
        )
      ],
    );
  }
}

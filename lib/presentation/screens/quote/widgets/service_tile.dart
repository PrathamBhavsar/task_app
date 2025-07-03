import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../domain/entities/service.dart';

class QuoteServiceTile extends StatelessWidget {
  const QuoteServiceTile({
    required this.service,
    required this.textStyle,
    super.key,
  });

  final Service service;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Text(service.serviceMaster.name, style: textStyle),
        ),
        Row(
          spacing: 25.w,
          children: [
            Text(service.quantity.toString(), style: textStyle),
            Text('₹${service.rate}', style: textStyle),
            Text('₹${service.amount}', style: textStyle),
          ],
        ),
      ],
    );
  }
}

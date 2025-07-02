import 'package:flutter/material.dart';

import '../../../../domain/entities/service.dart';
import '../../../../utils/constants/app_constants.dart';

class StaticServiceTile extends StatelessWidget {
  const StaticServiceTile({required this.service, super.key});

  final Service service;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            service.serviceMaster.name,
            softWrap: true,
            overflow: TextOverflow.visible,
            style: AppTexts.subtitleTextStyle,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            service.quantity.toString(),
            textAlign: TextAlign.center,
            style: AppTexts.subtitleTextStyle,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            service.rate.toStringAsFixed(2),
            textAlign: TextAlign.center,
            style: AppTexts.subtitleTextStyle,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            service.amount.toStringAsFixed(2),
            textAlign: TextAlign.right,
            style: AppTexts.subtitleTextStyle,
          ),
        ),
      ],
    );
  }
}

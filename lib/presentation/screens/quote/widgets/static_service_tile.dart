import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/di.dart';
import '../../../../core/helpers/cache_helper.dart';
import '../../../../domain/entities/service.dart';
import '../../../../domain/entities/service_master.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/extensions/padding.dart';
import '../../../blocs/measurement/measurement_bloc.dart';
import '../../../blocs/measurement/measurement_event.dart';
import '../../../widgets/bordered_container.dart';
import '../../../widgets/drop_down_menu.dart';
import '../../../widgets/labeled_text_field.dart';

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

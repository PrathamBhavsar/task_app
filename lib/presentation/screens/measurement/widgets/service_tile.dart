import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/extensions/padding.dart';
import '../../../blocs/measurement/measurement_bloc.dart';
import '../../../blocs/measurement/measurement_event.dart';
import '../../../widgets/bordered_container.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/labeled_text_field.dart';

class ServiceTile extends StatelessWidget {
  const ServiceTile({required this.index, super.key});

  final int index;

  @override
  Widget build(BuildContext context) {
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
                  onPressed:
                      () => context.read<MeasurementBloc>().add(
                        ServiceRemoved(index),
                      ),
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

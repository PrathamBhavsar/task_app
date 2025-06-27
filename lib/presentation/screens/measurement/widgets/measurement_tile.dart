import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/extensions/padding.dart';
import '../../../blocs/measurement/measurement_bloc.dart';
import '../../../blocs/measurement/measurement_event.dart';
import '../../../widgets/bordered_container.dart';
import '../../../widgets/labeled_text_field.dart';

class MeasurementTile extends StatelessWidget {
  const MeasurementTile({required this.index, super.key});

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
                        MeasurementRemoved(index),
                      ),
                  icon: Icon(
                    Icons.delete_outline_rounded,
                    color: AppColors.errorRed,
                  ),
                ),
              ],
            ),
            10.hGap,
            LabeledTextInput(title: 'Location', hint: 'Enter room location'),
            Row(
              children: [
                Expanded(
                  child: LabeledTextInput(
                    title: 'Width (inches)',
                    hint: '0.00',
                  ),
                ),
                10.wGap,
                Expanded(
                  child: LabeledTextInput(
                    title: 'Height (inches)',
                    hint: '0.00',
                  ),
                ),
              ],
            ),
            LabeledTextInput(
              title: 'Notes',
              hint: 'Enter note here',
              isMultiline: true,
            ),
          ],
        ),
      ),
    );
  }
}

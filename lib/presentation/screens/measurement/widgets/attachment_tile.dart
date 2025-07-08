import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/constants/app_constants.dart';
import '../../../blocs/measurement/measurement_cubit.dart';
import '../../../widgets/bordered_container.dart';

class AttachmentTile extends StatelessWidget {
  const AttachmentTile({required this.index, super.key});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: BorderedContainer(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'provider.attachments[index]',
              style: AppTexts.headingTextStyle,
            ),
            IconButton(
              padding: EdgeInsets.zero,
              onPressed:
                  () =>
                      context.read<MeasurementCubit>().removeAttachment(index),
              icon: Icon(
                Icons.delete_outline_rounded,
                color: AppColors.errorRed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

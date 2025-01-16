import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_app/constants/app_colors.dart';
import 'package:task_app/views/task/widgets/measurement/room_column.dart';

class MeasurementWidget extends StatelessWidget {
  const MeasurementWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPaddings.appPadding,
      child: Column(
        children: [
          InkWell(
            onTap: () {
              context.pushNamed('measurement');
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Measurement', style: AppTexts.headingStyle),
                Icon(Icons.arrow_forward_ios_rounded)
              ],
            ),
          ),
          AppPaddings.gapH(10),
          Container(
            decoration: BoxDecoration(
              color: AppColors.textFieldBg,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: EdgeInsets.all(18),
              child: Column(
                children: [
                  RoomColumn(),
                  _buildDivider(verticalPadding: 5),
                  RoomColumn(),
                  _buildDivider(verticalPadding: 5),
                  RoomColumn(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider({double verticalPadding = 0}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      child: Divider(color: AppColors.primary),
    );
  }
}

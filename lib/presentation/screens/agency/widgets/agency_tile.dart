import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../domain/entities/agency.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/constants/custom_icons.dart';
import '../../../../utils/extensions/padding.dart';
import '../../../widgets/action_button.dart';
import '../../../widgets/bordered_container.dart';
import '../../../widgets/custom_tag.dart';
import '../../../widgets/tile_row.dart';

class AgencyTile extends StatelessWidget {
  const AgencyTile({required this.agency, super.key, this.isSelected = false});

  final Agency agency;
  final bool isSelected;

  @override
  Widget build(BuildContext context) => BorderedContainer(
    isSelected: isSelected,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(agency.name, style: AppTexts.headingTextStyle),
                Text(agency.email, style: AppTexts.inputHintTextStyle),
              ],
            ),
            CustomTag(
              text: agency.status,
              color: Colors.black,
              textColor: Colors.white,
            ),
          ],
        ),
        10.hGap,
        TileRow(
          key1: 'Rating',
          value1: '${agency.rating.toString()}/5',
          key2: 'Pending Tasks',
          value2: agency.pendingTasks.toString(),
        ),
        10.hGap,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IntrinsicWidth(
              stepWidth: 20,
              child: ActionButton(
                label: 'View Details',
                prefixIcon: CustomIcon.eye,
                onPress:
                    () => context.push(AppRoutes.agencyDetails, extra: agency),
              ),
            ),
            10.wGap,
            IntrinsicWidth(
              stepWidth: 20,
              child: ActionButton(
                label: 'Call',
                prefixIcon: CustomIcon.phone,
                onPress: () {},
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

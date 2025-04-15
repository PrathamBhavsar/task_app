import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../data/models/Agency.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/extensions/padding.dart';
import '../../../widgets/action_button.dart';
import '../../../widgets/bordered_container.dart';
import '../../../widgets/custom_tag.dart';

class AgencyTile extends StatelessWidget {
  const AgencyTile({super.key, required this.agency});

  final Agency agency;

  @override
  Widget build(BuildContext context) => BorderedContainer(
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
        20.hGap,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Phone', style: AppTexts.inputHintTextStyle),
                Text('Rating', style: AppTexts.inputHintTextStyle),
                Text('Pending Tasks', style: AppTexts.inputHintTextStyle),
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(agency.phone, style: AppTexts.inputTextStyle),
                Text(
                  '${agency.rating.toString()}/5',
                  style: AppTexts.inputTextStyle,
                ),
                Text(
                  agency.pendingTasks.toString(),
                  style: AppTexts.inputTextStyle,
                ),
              ],
            ),
          ],
        ),
        10.hGap,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IntrinsicWidth(
              stepWidth: 20,
              child: ActionButton(
                label: 'View Details',
                onPress:
                    () => context.pushNamed('agencyDetails', extra: agency),
              ),
            ),
            10.wGap,
            IntrinsicWidth(
              stepWidth: 20,
              child: ActionButton(label: 'Call', onPress: () {}),
            ),
          ],
        ),
      ],
    ),
  );
}

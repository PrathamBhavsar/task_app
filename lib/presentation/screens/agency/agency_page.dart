import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants/app_constants.dart';
import '../../../utils/constants/custom_icons.dart';
import '../../../utils/extensions/padding.dart';
import '../../providers/task_provider.dart';
import '../../widgets/action_button.dart';
import '../../widgets/custom_text_field.dart';

// List<Agency> agencies = Agency.sampleAgencies;

class AgencyPage extends StatelessWidget {
  const AgencyPage({super.key});

  @override
  Widget build(BuildContext context) => Consumer<TaskProvider>(
    builder:
        (context, provider, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Agencies', style: AppTexts.titleTextStyle),
                IntrinsicWidth(
                  child: ActionButton(
                    label: 'New Agency',
                    onPress: () => context.push(AppRoutes.editAgency),
                    prefixIcon: CustomIcon.badgePlus,
                    fontColor: Colors.white,
                    backgroundColor: Colors.black,
                  ),
                ),
              ],
            ),
            10.hGap,
            CustomTextField(hintTxt: 'Search Agencies...', isSearch: true),
            10.hGap,
            _buildAgencies(context),
          ],
        ),
  );
  Widget _buildAgencies(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // ...List.generate(
      //   agencies.length,
      //   (index) => Padding(
      //     padding: index == 0 ? EdgeInsets.zero : EdgeInsets.only(top: 10.h),
      //     child: AgencyTile(agency: agencies[index]),
      //   ),
      // ),
    ],
  );
}

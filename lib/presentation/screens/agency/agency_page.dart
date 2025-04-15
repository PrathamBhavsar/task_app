import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../data/models/agency.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/extensions/padding.dart';
import '../../providers/task_provider.dart';
import '../../widgets/custom_text_field.dart';
import 'widgets/agency_tile.dart';

List<Agency> agencies = Agency.sampleAgencies;

class AgencyPage extends StatelessWidget {
  const AgencyPage({super.key});

  @override
  Widget build(BuildContext context) => Consumer<TaskProvider>(
    builder:
        (context, provider, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Agencies', style: AppTexts.titleTextStyle),
            10.hGap,
            CustomTextField(hintTxt: 'Search Agencies...'),
            10.hGap,
            _buildAgencies(context),
          ],
        ),
  );
  Widget _buildAgencies(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ...List.generate(
        agencies.length,
        (index) => Padding(
          padding: index == 0 ? EdgeInsets.zero : EdgeInsets.only(top: 10.h),
          child: AgencyTile(agency: agencies[index]),
        ),
      ),
    ],
  );
}

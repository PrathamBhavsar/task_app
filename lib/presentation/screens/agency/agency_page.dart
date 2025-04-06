import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../data/models/Agency.dart';
import '../../../data/models/task.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/extensions/padding.dart';
import '../../providers/home_provider.dart';
import '../../providers/task_provider.dart';
import '../../widgets/bordered_container.dart';
import '../../widgets/custom_tag.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/tab_header.dart';

List<Agency> agencies = Agency.sampleAgencys;

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
        _buildAgencies(),
      ],
    ),
  );
  Widget _buildAgencies() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ...List.generate(
        agencies.length,
            (index) => Padding(
          padding: index == 0 ? EdgeInsets.zero : EdgeInsets.only(top: 10.h),
          child: BorderedContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(agencies[index].name, style: AppTexts.titleTextStyle),
                        Text(
                          agencies[index].email,
                          style: AppTexts.inputHintTextStyle,
                        ),
                      ],
                    ),
                    CustomTag(
                      text: agencies[index].status,
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
                        Text('Orders', style: AppTexts.inputHintTextStyle),
                        Text('Total Spent', style: AppTexts.inputHintTextStyle),
                      ],
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          agencies[index].phone,
                          style: AppTexts.inputTextStyle,
                        ),
                        Text(
                          agencies[index].rating.toString(),
                          style: AppTexts.inputTextStyle,
                        ),
                        Text(
                          agencies[index].totalSpent,
                          style: AppTexts.inputTextStyle,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

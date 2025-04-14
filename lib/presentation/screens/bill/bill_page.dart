import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../data/models/bill.dart';
import '../../../data/models/customer.dart';
import '../../../data/models/task.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/extensions/padding.dart';
import '../../providers/home_provider.dart';
import '../../providers/task_provider.dart';
import '../../widgets/action_button.dart';
import '../../widgets/bordered_container.dart';
import '../../widgets/custom_tag.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/tab_header.dart';
import '../../widgets/tile_row.dart';

List<Bill> customers = Bill.sampleBills;

class BillPage extends StatelessWidget {
  const BillPage({super.key});

  @override
  Widget build(BuildContext context) => Consumer<TaskProvider>(
    builder:
        (context, provider, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Bills', style: AppTexts.titleTextStyle),
            TabHeader(
              tabs: [
                Tab(text: 'Pending'),
                Tab(text: 'Approved'),
                Tab(text: 'Paid'),
                Tab(text: 'Rejected'),
              ],
            ),
            10.hGap,
            _buildBills(),
          ],
        ),
  );
  Widget _buildBills() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ...List.generate(
        customers.length,
        (index) => Padding(
          padding: index == 0 ? EdgeInsets.zero : EdgeInsets.only(top: 10.h),
          child: BorderedContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            customers[index].name,
                            overflow: TextOverflow.ellipsis,
                            style: AppTexts.headingTextStyle,
                          ),
                          Text(
                            customers[index].agency,
                            style: AppTexts.inputHintTextStyle,
                          ),
                          Text(
                            customers[index].task,
                            style: AppTexts.inputHintTextStyle,
                          ),
                          Text(
                            customers[index].place,
                            style: AppTexts.inputHintTextStyle,
                          ),
                        ],
                      ),
                    ),
                    CustomTag(
                      text: customers[index].status,
                      color: Colors.black,
                      textColor: Colors.white,
                    ),
                  ],
                ),
                10.hGap,
                TileRow(
                  key1: 'Bill Date',
                  value1: customers[index].createdAt,
                  key2: 'Due Date',
                  value2: customers[index].createdAt,
                ),
                10.hGap,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IntrinsicWidth(
                      stepWidth: 20,
                      child: ActionButton(label: 'View Task', onPress: () {}),
                    ),
                    10.wGap,
                    IntrinsicWidth(
                      stepWidth: 20,
                      child: ActionButton(
                        label: 'Review Bill',
                        backgroundColor: Colors.black,
                        fontColor: Colors.white,
                        onPress: () {},
                      ),
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

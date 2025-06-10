import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/bill.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/extensions/padding.dart';
import '../../providers/task_provider.dart';
import '../../widgets/tab_header.dart';
import 'widgets/bill_tile.dart';

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
            // Builder(
            //   builder: (context) {
            //     switch (provider.tabIndex) {
            //       case 0:
            //         return _buildBills(Bill.pendingBills);
            //       case 1:
            //         return _buildBills(Bill.approvedBills);
            //       case 2:
            //         return _buildBills(Bill.paidBills);
            //       default:
            //         return _buildBills(Bill.rejectedBills);
            //     }
            //   },
            // ),
          ],
        ),
  );
  Widget _buildBills(List<Bill> list) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ...List.generate(
        list.length,
        (index) => Padding(
          padding: index == 0 ? EdgeInsets.zero : EdgeInsets.only(top: 10.h),
          child: BillTile(bill: list[index]),
        ),
      ),
    ],
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../domain/entities/bill.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/enums/bill_status.dart';
import '../../../utils/extensions/padding.dart';
import '../../blocs/bill/bill_bloc.dart';
import '../../blocs/bill/bill_state.dart';
import '../../blocs/tab/tab_bloc.dart';
import '../../widgets/tab_header.dart';
import 'widgets/bill_tile.dart';

class BillPage extends StatelessWidget {
  const BillPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BillBloc, BillState>(
      builder: (context, billState) {
        if (billState is BillLoadInProgress) {
          return const Center(child: CircularProgressIndicator());
        }

        if (billState is BillLoadFailure) {
          return const Center(child: Text('There was an issue loading bills!'));
        }

        if (billState is BillLoadSuccess) {
          final bills = billState.bills;

          if (bills.isEmpty) {
            return const Center(child: Text('There are no bills!'));
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Bills', style: AppTexts.titleTextStyle),
              TabHeader(
                tabs: [
                  Tab(text: BillStatus.pending.status),
                  Tab(text: BillStatus.approved.status),
                  Tab(text: 'Paid'),
                  Tab(text: BillStatus.rejected.status),
                ],
              ),
              10.hGap,
              BlocBuilder<TabBloc, TabState>(
                builder: (context, tabState) {
                  final index = tabState.tabIndex;

                  List<Bill> selectedBills;
                  switch (index) {
                    case 0:
                      selectedBills =
                          bills
                              .where((b) => b.status == BillStatus.pending)
                              .toList();
                      break;
                    case 1:
                      selectedBills =
                          bills
                              .where((b) => b.status == BillStatus.approved)
                              .toList();
                      break;
                    case 2:
                      selectedBills =
                          bills
                              .where((b) => b.status == BillStatus.rejected)
                              .toList();
                      break;
                    case 3:
                      selectedBills =
                          bills
                              .where((b) => b.status == BillStatus.rejected)
                              .toList();
                      break;
                    default:
                      selectedBills = bills;
                  }

                  return _buildBills(selectedBills);
                },
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildBills(List<Bill> list) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        list.length,
        (index) => Padding(
          padding: index == 0 ? EdgeInsets.zero : EdgeInsets.only(top: 10.h),
          child: BillTile(bill: list[index]),
        ),
      ),
    );
  }
}

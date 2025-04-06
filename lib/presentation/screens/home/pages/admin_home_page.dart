import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/extensions/padding.dart';
import '../../../providers/transaction_provider.dart';
import '../../../widgets/bordered_container.dart';
import '../../../widgets/chart_widget.dart';
import '../../../widgets/pie_chart.dart';
import '../widgets/dashboard_containers.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) => Consumer<TransactionProvider>(
    builder:
        (BuildContext context, TransactionProvider provider, Widget? child) =>
            Column(
              children: [
                DashboardContainers(),
                10.hGap,
                _buildSalesOverview(provider),
                10.hGap,
                _buildTaskStatistics(provider),
                10.hGap,
                _buildRecentTasks(),
              ],
            ),
  );

  Widget _buildRecentTasks() => BorderedContainer(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Recent Tasks",
              style: AppTexts.titleTextStyle,
            ).padSymmetric(vertical: 20.h, horizontal: 10.w),
            Row(
              children: [
                Text('View All', style: AppTexts.inputLabelTextStyle),
                5.wGap,
                Icon(
                  Icons.arrow_forward_rounded,
                  applyTextScaling: true,
                  size: 14.sp,
                ),
              ],
            ),
          ],
        ),
        ...List.generate(
          3,
          (index) => Padding(
            padding: index == 0 ? EdgeInsets.zero : EdgeInsets.only(top: 10.h),
            child: BorderedContainer(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Task #00${index + 1}",
                        style: AppTexts.titleTextStyle,
                      ),
                      Text("Customer Name", style: AppTexts.inputHintTextStyle),
                    ],
                  ),
                  Text('View', style: AppTexts.inputLabelTextStyle),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );

  Widget _buildTaskStatistics(TransactionProvider provider) =>
      BorderedContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Task Statistics",
              style: AppTexts.titleTextStyle,
            ).padSymmetric(vertical: 20.h, horizontal: 10.w),
            PieChart(),
          ],
        ),
      );

  Widget _buildSalesOverview(TransactionProvider provider) => BorderedContainer(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Overview",
          style: AppTexts.titleTextStyle,
        ).padSymmetric(vertical: 20.h, horizontal: 10.w),
        ChartWidget(),
      ],
    ),
  );
}

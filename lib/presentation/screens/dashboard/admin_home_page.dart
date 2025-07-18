import 'package:flutter/material.dart';
import '../../../utils/constants/app_constants.dart';
import '../../../utils/constants/dummy_data.dart';
import '../../../utils/extensions/padding.dart';
import '../../widgets/bordered_container.dart';
import '../../widgets/chart_widget.dart';
import '../../widgets/pie_chart.dart';
import '../home/widgets/dashboard_containers.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          DashboardContainers(list: DummyData.adminDashboard),
          10.hGap,
          _buildSalesOverview(),
          10.hGap,
          _buildTaskStatistics(),
        ],
      ),
    );
  }

  Widget _buildTaskStatistics() => BorderedContainer(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Task Statistics", style: AppTexts.titleTextStyle),
        10.hGap,
        PieChart(),
      ],
    ),
  );

  Widget _buildSalesOverview() => BorderedContainer(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Overview", style: AppTexts.titleTextStyle),
        10.hGap,
        ChartWidget(),
      ],
    ),
  );
}

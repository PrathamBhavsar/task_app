import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../data/models/task.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/constants/custom_icons.dart';
import '../../../../utils/constants/dummy_data.dart';
import '../../../../utils/extensions/padding.dart';
import '../../../providers/task_provider.dart';
import '../../../widgets/bordered_container.dart';
import '../../../widgets/chart_widget.dart';
import '../../../widgets/pie_chart.dart';
import '../widgets/dashboard_containers.dart';

final List<Task> tasks = Task.pendingTasks;

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) => Consumer<TaskProvider>(
    builder:
        (BuildContext context, TaskProvider provider, Widget? child) => Column(
          children: [
            DashboardContainers(list: DummyData.adminDashboard),
            10.hGap,
            _buildSalesOverview(provider),
            10.hGap,
            _buildTaskStatistics(provider),
            10.hGap,
            _buildRecentTasks(context),
          ],
        ),
  );

  Widget _buildRecentTasks(BuildContext context) => BorderedContainer(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Recent Tasks", style: AppTexts.titleTextStyle),
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
        10.hGap,
        ...List.generate(
          2,
          (index) => Padding(
            padding: index == 0 ? EdgeInsets.zero : EdgeInsets.only(top: 10.h),
            child: GestureDetector(
              onTap:
                  () =>
                      context.push(AppRoutes.taskDetails, extra: tasks[index]),
              child: BorderedContainer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tasks[index].name,
                          style: AppTexts.headingTextStyle,
                        ),
                        Text(
                          tasks[index].customer,
                          style: AppTexts.inputHintTextStyle,
                        ),
                      ],
                    ),
                    Icon(CustomIcon.chevronRight, color: Colors.black),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );

  Widget _buildTaskStatistics(TaskProvider provider) => BorderedContainer(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Task Statistics", style: AppTexts.titleTextStyle),
        10.hGap,
        PieChart(),
      ],
    ),
  );

  Widget _buildSalesOverview(TaskProvider provider) => BorderedContainer(
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

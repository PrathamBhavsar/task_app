import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../data/models/dashboard_detail.dart';
import '../../../../../utils/constants/app_consts.dart';
import '../../../../../utils/extensions/app_paddings.dart';
import '../../../../../utils/extensions/color_extension.dart';
import '../../../../providers/task_provider.dart';
import '../task list/widgets/task_tile.dart';
import 'widgets/page_view.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);

    return Skeletonizer(
      enabled: provider.isLoading,
      enableSwitchAnimation: true,
      effect: ShimmerEffect(),
      textBoneBorderRadius: TextBoneBorderRadius(BorderRadius.circular(10)),
      containersColor: Colors.grey,
      child: _buildBody(provider),
    );
  }

  Widget _buildBody(TaskProvider provider) {
    final categorizedDetails = _groupByCategory(provider.dashboardDetails);
    final sortedCategories = categorizedDetails.keys.toList()..sort();
    final dueTodayTasksWidgets = provider.dueTodayTasks
        .map((task) => TaskTile(task: task).padAll(10))
        .toList();
    final pastDueTasksWidgets = provider.pastDueTasks
        .map((task) => TaskTile(task: task).padAll(10))
        .toList();

    if (sortedCategories.isEmpty) {
      return Center(child: Text("No categories found"));
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          ExpandablePageView(
            children: sortedCategories
                .map((category) =>
                    _buildCategoryPage(category, categorizedDetails[category]!))
                .toList(),
          ),
          ExpandablePageView(
            title: 'Due Today',
            altTitle: 'No Tasks Due Today',
            children: dueTodayTasksWidgets,
          ),
          ExpandablePageView(
            title: 'Past Due',
            altTitle: 'Tasks Up-to date',
            children: pastDueTasksWidgets,
          ),
        ],
      ),
    );
  }

  Map<String, List<DashboardStatus>> _groupByCategory(
          List<DashboardStatus> dashboardDetails) =>
      {
        for (var detail in dashboardDetails)
          detail.category?.isNotEmpty == true
              ? detail.category!
              : 'Uncategorized': [
            ...(dashboardDetails.where((d) => d.category == detail.category))
          ]
      };

  Widget _buildCategoryPage(
          String category, List<DashboardStatus> categoryItems) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(category, style: AppTexts.headingStyle),
          10.hGap,
          categoryItems.length > 2
              ? GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 60.h,
                    crossAxisSpacing: 12.h,
                    mainAxisSpacing: 12.h,
                  ),
                  itemCount: categoryItems.length,
                  itemBuilder: (context, index) =>
                      _buildTile(categoryItems[index]),
                )
              : Column(
                  children: categoryItems
                      .map((item) => _buildTile(item).padSymmetric(vertical: 5))
                      .toList(),
                ),
        ],
      ).padAll(AppPaddings.appPaddingInt);

  Widget _buildTile(DashboardStatus data) => Container(
        height: 60.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.primary, width: 2),
          color: data.color.toColor(),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  data.statusName.split(':').last.trim(),
                  style: AppTexts.headingStyle,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  maxLines: 1,
                ),
              ),
              8.wGap,
              Skeleton.ignore(
                child: Text(
                  data.taskCount.toString(),
                  style: AppTexts.headingStyle,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
      );
}

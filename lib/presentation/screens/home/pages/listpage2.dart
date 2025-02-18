import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_consts.dart';
import '../../../../data/models/dashboard_detail.dart';
import '../../../../old/extensions/app_paddings.dart';
import '../../../../old/views/home/pages/task list/widgets/task_tile.dart';
import '../../../providers/task_provider.dart';
import 'widgets/page_view.dart';
import 'widgets/task_tileee.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);

    if (provider.isLoading) {
      return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: provider.fetchTasks,
              child: Text('fetch'),
            ),
          ],
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final categorizedDetails = _groupByCategory(provider.dashboardDetails);
    final sortedCategories = categorizedDetails.keys.toList()..sort();

    final dueTodayTasks = provider.dueTodayTasks;

    if (sortedCategories.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: provider.fetchTasks,
              child: Text('fetch'),
            ),
          ],
        ),
        body: Center(child: Text("No categories found")),
      );
    }

    List<Widget> categoryWidgets = sortedCategories.map((category) {
      final categoryItems = categorizedDetails[category]!;
      return _buildCategoryPage(category, categoryItems);
    }).toList();

    List<Widget> dueTodayTasksWidgets =
        dueTodayTasks.map((task) => TaskTile1(task: task)).toList();

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: provider.fetchTasks,
            child: Text('fetch'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ExpandablePageView(
              children: categoryWidgets,
            ),
            dueTodayTasksWidgets.isNotEmpty
                ? ExpandablePageView(
                    children: dueTodayTasksWidgets,
                  )
                : Center(
                    child: Text("No Tasks Due Today"),
                  ),
          ],
        ),
      ),
    );
  }

  Map<String, List<DashboardStatus>> _groupByCategory(
      List<DashboardStatus> dashboardDetails) {
    Map<String, List<DashboardStatus>> categorizedDetails = {};

    for (var detail in dashboardDetails) {
      if (detail.category != null && detail.category!.isNotEmpty) {
        if (!categorizedDetails.containsKey(detail.category)) {
          categorizedDetails[detail.category!] = [];
        }
        categorizedDetails[detail.category]!.add(detail);
      } else {
        categorizedDetails['Uncategorized'] = [
          ...categorizedDetails['Uncategorized'] ?? [],
          detail
        ];
      }
    }

    return categorizedDetails;
  }

  Widget _buildCategoryPage(
      String category, List<DashboardStatus> categoryItems) {
    bool isGrid = categoryItems.length > 2;

    return Padding(
      padding: AppPaddings.appPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            category,
            style: AppTexts.headingStyle,
          ),
          10.hGap,
          isGrid
              ? GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 70.h,
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
      ),
    );
  }

  Widget _buildTile(DashboardStatus data) {
    final displayName = data.statusName.split(':').last.trim();

    final Color tileColor = Colors.white;

    return Container(
      height: 70.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primary,
          width: 2,
        ),
        color: tileColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                displayName,
                style: AppTexts.headingStyle,
                overflow: TextOverflow.fade,
                softWrap: false,
                maxLines: 1,
              ),
            ),
            8.wGap,
            Text(
              data.taskCount.toString(),
              style: AppTexts.headingStyle,
              overflow: TextOverflow.fade,
              softWrap: false,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}

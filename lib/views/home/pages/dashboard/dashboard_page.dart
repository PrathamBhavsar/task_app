import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../constants/app_colors.dart';
import '../../../../constants/dummy_data.dart';
import '../../../../providers/task_provider.dart';
import '../task%20list/widgets/task_tile.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Future<void> _userFuture;
  final PageController _pageController = PageController();
  final PageController _taskPageController = PageController();
  @override
  void initState() {
    super.initState();
    _userFuture = Future.delayed(const Duration(seconds: 2));
    // _userFuture = TaskProvider.instance.getOverallCounts();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _taskPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
      future: _userFuture,
      builder: (context, snapshot) {
        final screenWidth = MediaQuery.of(context).size.width;

        return Consumer<TaskProvider>(
          builder:
              (BuildContext context, TaskProvider provider, Widget? child) {
            final taskCounts = DummyData.dummyTaskCounts;
            final task = DummyData.dummyTask;
            final fetchedData = DummyData.dummyFetchedData;

            final groupedCounts = <String, List<Map<String, dynamic>>>{};
            taskCounts.entries
                .where((entry) => entry.value > 0)
                .forEach((entry) {
              final prefix = entry.key.split(':').first;
              groupedCounts.putIfAbsent(prefix, () => []).add({
                'name': entry.key,
                'count': entry.value,
              });
            });

            // List of categories
            final categories = groupedCounts.keys.toList();
            // final colors = provider.fetchedData['task_status'];
            // final task = provider.fetchedData['shared_tasks'];

            final colors = fetchedData['task_status'];

            return Padding(
              padding: AppPaddings.appPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      categories[provider.currentTaskPage],
                      style: AppTexts.headingStyle,
                    ),
                  ),
                  AppPaddings.gapH(10),
                  SizedBox(
                    height: 136.h,
                    width: screenWidth,
                    child: PageView.builder(
                      itemCount: categories.length,
                      controller: _pageController,
                      onPageChanged: (page) {
                        provider.updateCurrentTaskPage(page);
                      },
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        final items = groupedCounts[category]!;

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              if (items.isNotEmpty)
                                _buildPageColumn(
                                  items[0],
                                  items.length > 1 ? items[1] : null,
                                  colors,
                                ),
                              AppPaddings.gapW(8),
                              if (items.length > 2)
                                _buildPageColumn(
                                  items[2],
                                  items.length > 3 ? items[3] : null,
                                  colors,
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  _buildDotIndicator(
                      categories.length, provider.currentTaskPage),
                  AppPaddings.gapH(10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Tasks Due Today',
                      style: AppTexts.headingStyle,
                    ),
                  ),
                  AppPaddings.gapH(10),
                  task != null ? _buildTodayTasks(task) : SizedBox.shrink(),
                  _buildDotIndicator(
                      task.length, provider.currentTodayTaskPage),
                  AppPaddings.gapH(10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Tasks By User',
                      style: AppTexts.headingStyle,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );

  Widget _buildPageViews<T>({
    required List<T> data,
    required PageController controller,
    required Function(int) onPageChanged,
    required Widget Function(BuildContext, int) itemBuilder,
    double height = 148.0,
  }) => SizedBox(
      height: height.h,
      child: PageView.builder(
        controller: controller,
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        onPageChanged: onPageChanged,
        itemBuilder: itemBuilder,
      ),
    );

  Widget _buildTodayTasks(List<Map<String, dynamic>> tasks) => _buildPageViews(
      data: tasks,
      controller: _taskPageController,
      onPageChanged: (page) {
        TaskProvider.instance.updateCurrentTodayTaskPage(page);
      },
      itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 10, right: 10),
          child: TaskTile(task: tasks[index]),
        ),
    );

  Widget _buildPageColumn(
      Map<String, dynamic>? topItem,
      Map<String, dynamic>? bottomItem,
      List<Map<String, dynamic>>? taskStatusColors) => Flexible(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (topItem != null) _buildTile(topItem, taskStatusColors),
          AppPaddings.gapH(8),
          if (bottomItem != null) _buildTile(bottomItem, taskStatusColors),
        ],
      ),
    );

  Widget _buildTile(
      Map<String, dynamic> data, List<Map<String, dynamic>>? taskStatusColors) {
    final displayName = data['name'].split(':').last.trim();

    final colorMap = taskStatusColors?.firstWhere(
      (color) => color['name'].trim() == data['name'],
    );

    final Color tileColor =
        TaskProvider.instance.stringToColor(colorMap?['color'] ?? 'ffffffff');

    return Container(
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primary,
          width: 2,
        ),
        color: tileColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              displayName,
              style: AppTexts.headingStyle,
              overflow: TextOverflow.fade,
              softWrap: false,
              maxLines: 1,
            ),
            Text(
              '${data['count']}',
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

  Widget _buildDotIndicator(int pageCount, int currentPage) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(pageCount, (index) => AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            width: currentPage == index ? 8 : 3,
            height: currentPage == index ? 8 : 3,
            decoration: BoxDecoration(
              color: currentPage == index ? AppColors.primary : Colors.grey,
              shape: BoxShape.circle,
            ),
          )),
      ),
    );
}

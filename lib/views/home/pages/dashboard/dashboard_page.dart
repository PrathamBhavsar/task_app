import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/constants/app_colors.dart';
import 'package:task_app/providers/task_provider.dart';
import 'package:task_app/views/home/pages/task%20list/widgets/task_tile.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Future<void> _userFuture;
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    // _userFuture = Future.delayed(const Duration(
    //     seconds: 2));
    _userFuture = TaskProvider.instance.getOverallCounts();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _userFuture,
      builder: (context, snapshot) {
        final screenWidth = MediaQuery.of(context).size.width;

        return Consumer<TaskProvider>(
          builder:
              (BuildContext context, TaskProvider provider, Widget? child) {
            final taskCounts = {
              "Task: In Progress": 1,
              "Measurement: Shared": 1,
              "Measurement: Accepted": 1,
              "Measurement: Rejected": 1,
              "Measurement: In Progress": 1,
              "Measurement: Completed": 1,
              "Quotation: Created": 1,
              "Quotation: Shared": 1,
              "Quotation: Accepted": 1,
              "Quotation: Rejected": 1,
              "Task: Completed": 1,
              "Payment: Paid": 1,
              "Payment: Unpaid": 1,
            };
            final List<Map<String, dynamic>> fetchedData = [
              {
                "order": 6,
                "created_at": "2025-01-07T08:57:08.726362 00:00",
                "slug": "measurement_made",
                "color": "ff321512",
                "name": "Measurement: Completed",
                "category": "Measurement",
              },
              {
                "order": 7,
                "created_at": "2025-01-06T06:39:30.008843 00:00",
                "slug": "quotation_made",
                "color": "ff9B59B6",
                "name": "Quotation: Created",
                "category": "Quotation",
              },
              {
                "order": 8,
                "created_at": "2025-01-06T06:39:30.008843 00:00",
                "slug": "sent_to_agency_quotation",
                "color": "ff7D3C98",
                "name": "Quotation: Shared",
                "category": "Quotation",
              },
              {
                "order": 9,
                "created_at": "2025-01-06T06:39:30.008843 00:00",
                "slug": "quotation_accepted",
                "color": "ff1ABC9C",
                "name": "Quotation: Accepted",
                "category": "Quotation",
              },
              {
                "order": 10,
                "created_at": "2025-01-07T08:58:18.767105 00:00",
                "slug": "quotation_rejected",
                "color": "ff325489",
                "name": "Quotation: Rejected",
                "category": "Quotation",
              },
              {
                "order": 11,
                "created_at": "2025-01-06T06:39:30.008843 00:00",
                "slug": "completed",
                "color": "ff2C3E50",
                "name": "Task: Completed",
                "category": "Task",
              },
              {
                "order": 12,
                "created_at": "2025-01-06T06:39:30.008843 00:00",
                "slug": "paid",
                "color": "ff2C3E50",
                "name": "Payment: Paid",
                "category": "Payment",
              },
              {
                "order": 13,
                "created_at": "2025-01-06T06:39:30.008843 00:00",
                "slug": "unpaid",
                "color": "ff2C3E50",
                "name": "Payment: Unpaid",
                "category": "Payment",
              },
              {
                "order": 1,
                "created_at": "2025-01-01T06:40:52.679867 00:00",
                "slug": "in_progress_sales",
                "color": "ff9d9bff",
                "name": "Task: In Progress",
                "category": "Task",
              },
              {
                "order": 2,
                "created_at": "2025-01-01T06:41:25.96586 00:00",
                "slug": "sent_to_agency",
                "color": "ff9d9bff",
                "name": "Measurement: Shared",
                "category": "Measurement",
              },
              {
                "order": 3,
                "created_at": "2025-01-01T06:41:42.132443 00:00",
                "slug": "accepted_by_agency",
                "color": "ff9d9bff",
                "name": "Measurement: Accepted",
                "category": "Measurement",
              },
              {
                "order": 4,
                "created_at": "2025-01-06T06:39:30.008843 00:00",
                "slug": "rejected_by_agency",
                "color": "ff85C1E9",
                "name": "Measurement: Rejected",
                "category": "Measurement",
              },
              {
                "order": 5,
                "created_at": "2025-01-06T06:39:30.008843 00:00",
                "slug": "in_progress_agency",
                "color": "ff28B463",
                "name": "Measurement: In Progress",
                "category": "Measurement",
              }
            ];
            final taskw = [
              {
                "task_category": "shared_tasks",
                "id": "d476cc80-a212-4b2b-bfc2-9e002c0cd8d2",
                "deal_no": "25-0019",
                "name": "test",
                "created_at": "2025-01-07T08:26:55.63643+00:00",
                "start_date": "2025-01-07T13:47:15.812646+00:00",
                "due_date": "2025-01-09T13:47:15.811486+00:00",
                "priority": "High",
                "created_by": "1c92cb0c-f0f1-4715-a5ad-8104952847e7",
                "remarks": "test",
                "status": "Measurement: Shared",
                "user_ids": [
                  "1c92cb0c-f0f1-4715-a5ad-8104952847e7",
                  "f7c84cb0-f16e-4e6c-8f76-dd629007fb78"
                ]
              },
              {
                "task_category": "shared_tasks",
                "id": "d476cc80-a212-4b2b-bfc2-9e002c0cd8d2",
                "deal_no": "25-0019",
                "name": "test",
                "created_at": "2025-01-07T08:26:55.63643+00:00",
                "start_date": "2025-01-07T13:47:15.812646+00:00",
                "due_date": "2025-01-09T13:47:15.811486+00:00",
                "priority": "High",
                "created_by": "1c92cb0c-f0f1-4715-a5ad-8104952847e7",
                "remarks": "test",
                "status": "Measurement: Shared",
                "user_ids": [
                  "1c92cb0c-f0f1-4715-a5ad-8104952847e7",
                  "f7c84cb0-f16e-4e6c-8f76-dd629007fb78"
                ]
              },
            ];

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
            final colors = provider.fetchedData['task_status'];
            final task = provider.fetchedData['shared_tasks'];
            // final colors = fetchedData;

            return Padding(
              padding: AppPaddings.appPadding,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      categories[_currentPage],
                      style: AppTexts.headingStyle,
                    ),
                  ),
                  AppPaddings.gapH(10),
                  SizedBox(
                    height: 165,
                    width: screenWidth,
                    child: PageView.builder(
                      itemCount: categories.length,
                      controller: _pageController,
                      onPageChanged: (page) {
                        setState(() {
                          _currentPage = page;
                        });
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
                              if (items.length > 0)
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
                  _buildDotIndicator(categories.length),
                  AppPaddings.gapH(10),
                  // _buildTodayTasks(task ?? []),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildTodayTasks(List<Map<String, dynamic>> task) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        height: 150,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: task.length,
          itemBuilder: (BuildContext context, int index) {
            if (task.isEmpty) {
              return Center(
                child: Text(
                  'noListText',
                  style: AppTexts.headingStyle,
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TaskTile(task: task[index]),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPageColumn(
      Map<String, dynamic>? topItem,
      Map<String, dynamic>? bottomItem,
      List<Map<String, dynamic>>? taskStatusColors) {
    return Flexible(
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
  }

  Widget _buildTile(
      Map<String, dynamic> data, List<Map<String, dynamic>>? taskStatusColors) {
    final displayName = data['name'].split(':').last.trim();

    // Find the corresponding color based on the task name
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

  Widget _buildDotIndicator(int pageCount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(pageCount, (index) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            width: _currentPage == index ? 8 : 3,
            height: _currentPage == index ? 8 : 3,
            decoration: BoxDecoration(
              color: _currentPage == index ? AppColors.primary : Colors.grey,
              shape: BoxShape.circle,
            ),
          );
        }),
      ),
    );
  }
}

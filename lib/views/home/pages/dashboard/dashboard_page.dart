import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/constants/app_colors.dart';
import 'package:task_app/providers/task_provider.dart';

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
    _userFuture = Future.delayed(const Duration(seconds: 1));
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
        final List<Map<String, dynamic>> count = List.generate(
          20,
          (index) => {'name': 'Task ${index + 1}', 'count': index + 1},
        );

        final screenWidth = MediaQuery.of(context).size.width;
        final containerWidth = (screenWidth / 2) - 24; 
        return Consumer<TaskProvider>(
          builder:
              (BuildContext context, TaskProvider provider, Widget? child) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16, bottom: 8),
                  child: SizedBox(
                    height: 175,
                    width: screenWidth,
                    child: PageView.builder(
                      itemCount: (count.length / 4).ceil(),
                      controller: _pageController,
                      onPageChanged: (page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        int firstItemIndex = index * 4;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            if (firstItemIndex < count.length)
                              _buildPageColumn(
                                count[firstItemIndex],
                                count.length > firstItemIndex + 1
                                    ? count[firstItemIndex + 1]
                                    : null,
                                containerWidth,
                              ),
                            if (count.length > firstItemIndex + 2)
                              _buildPageColumn(
                                count[firstItemIndex + 2],
                                count.length > firstItemIndex + 3
                                    ? count[firstItemIndex + 3]
                                    : null,
                                containerWidth,
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                _buildDotIndicator((count.length / 4).ceil()),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildPageColumn(Map<String, dynamic>? topItem,
      Map<String, dynamic>? bottomItem, double width) {
    return SizedBox(
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (topItem != null) _buildTile(topItem),
          if (bottomItem != null) _buildTile(bottomItem),
        ],
      ),
    );
  }

  Widget _buildTile(Map<String, dynamic> data) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primary,
          width: 1.8,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.green,
                border: Border.all(width: 2),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['name'],
                    style: AppTexts.headingStyle,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${data['count'] + 1000000}',
                    style: AppTexts.headingStyle,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    maxLines: 1,
                  ),
                ],
              ),
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

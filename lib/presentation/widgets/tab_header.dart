import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../utils/constants/app_constants.dart';
import '../providers/task_provider.dart';

class TabHeader extends StatefulWidget {
  const TabHeader({required this.tabs, super.key});
  final List<Tab> tabs;
  @override
  State<TabHeader> createState() => _TabHeaderState();
}

class _TabHeaderState extends State<TabHeader> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.tabs.length,
      vsync: this,
      initialIndex: 0,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) => Consumer<TaskProvider>(
    builder:
        (context, provider, child) => Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: AppBorders.radius,
                color: AppColors.accent,
              ),
              padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
              child: TabBar(
                textScaler: TextScaler.linear(0.9),
                tabAlignment: TabAlignment.fill,
                controller: _tabController,
                onTap: provider.updateSubTabIndex,
                indicatorSize: TabBarIndicatorSize.tab,
                unselectedLabelColor: Colors.grey,
                labelStyle: AppTexts.headingTextStyle.copyWith(
                  color: Colors.black,
                  fontVariations: [FontVariation.weight(700)],
                ),
                indicator: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                dividerColor: Colors.transparent,
                padding: EdgeInsets.zero,
                indicatorPadding: EdgeInsets.zero,
                labelPadding: EdgeInsets.symmetric(horizontal: 10.w),
                tabs: widget.tabs,
              ),
            ),
          ),
        ),
  );
}

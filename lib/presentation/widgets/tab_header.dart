import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/constants/app_constants.dart';
import '../providers/transaction_provider.dart';

class TabHeader extends StatefulWidget {
  const TabHeader({super.key, required this.provider, required this.tabs});
  final TransactionProvider provider;
  final List<Tab> tabs;
  @override
  State<TabHeader> createState() => _TabHeaderState();
}

class _TabHeaderState extends State<TabHeader> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(vertical: 10.h),
    child: Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: AppBorders.radius,
          color: AppColors.accent,
        ),
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
        child: TabBar(
          tabAlignment: TabAlignment.fill,
          controller: _tabController,
          onTap: widget.provider.updateSubTabIndex,
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
          textScaler: TextScaler.linear(0.8),
          tabs: widget.tabs,
        ),
      ),
    ),
  );
}

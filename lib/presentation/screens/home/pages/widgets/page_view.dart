import 'package:flutter/material.dart';
import '../../../../../core/constants/app_consts.dart';
import 'size_reporting_widget.dart';

class ExpandablePageView extends StatefulWidget {
  final List<Widget> children;
  final String? title;
  final String? altTitle;

  const ExpandablePageView({
    super.key,
    required this.children,
    this.title,
    this.altTitle,
  });

  @override
  State<ExpandablePageView> createState() => _ExpandablePageViewState();
}

class _ExpandablePageViewState extends State<ExpandablePageView>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late List<double> _heights;
  int _currentPage = 0;

  double get _currentHeight => _heights[_currentPage];

  @override
  void initState() {
    _heights = widget.children.map((e) => 0.0).toList();
    super.initState();
    _pageController = PageController()
      ..addListener(() {
        final newPage = _pageController.page?.round() ?? 0;
        if (_currentPage != newPage) {
          setState(() => _currentPage = newPage);
        }
      });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.children.isEmpty
      ? Center(
          child: Text(
            widget.altTitle ?? "",
          ),
        )
      : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title ?? "",
              style: AppTexts.headingStyle,
            ),
            TweenAnimationBuilder<double>(
              curve: Curves.easeInOutCubic,
              duration: const Duration(milliseconds: 100),
              tween: Tween<double>(begin: _heights[0], end: _currentHeight),
              builder: (context, value, child) =>
                  SizedBox(height: value, child: child),
              child: PageView(
                padEnds: true,
                controller: _pageController,
                children: _sizeReportingChildren
                    .asMap()
                    .map(MapEntry.new)
                    .values
                    .toList(),
              ),
            ),
            _buildDotIndicator(_sizeReportingChildren.length, _currentPage),
          ],
        );

  Widget _buildDotIndicator(int pageCount, int currentPage) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            pageCount,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              width: currentPage == index ? 8 : 3,
              height: currentPage == index ? 8 : 3,
              decoration: BoxDecoration(
                color: currentPage == index ? AppColors.primary : Colors.grey,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      );

  List<Widget> get _sizeReportingChildren => widget.children
      .asMap()
      .map(
        (index, child) => MapEntry(
          index,
          OverflowBox(
            minHeight: 0,
            maxHeight: double.infinity,
            alignment: Alignment.topCenter,
            child: SizeReportingWidget(
              onSizeChange: (size) =>
                  setState(() => _heights[index] = size.height),
              child: Align(child: child),
            ),
          ),
        ),
      )
      .values
      .toList();
}

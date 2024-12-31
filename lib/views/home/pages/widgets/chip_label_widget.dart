import 'package:flutter/material.dart';
import 'package:task_app/constants/app_colors.dart';

class ChipLabelWidget extends StatelessWidget {
  const ChipLabelWidget(
      {super.key,
      required this.tabs,
      required this.index,
      required this.selectedIndex});
  final List<Map<String, dynamic>> tabs;
  final int index;
  final int selectedIndex;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          tabs[index]['label'],
          style: TextStyle(
            color: selectedIndex == index ? Colors.white : AppColors.primary,
            fontWeight: FontWeight.w900,
            fontSize: 18,
          ),
        ),
        AppPaddings.gapW(10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: tabs[index]['color'],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              '${tabs[index]['count']}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

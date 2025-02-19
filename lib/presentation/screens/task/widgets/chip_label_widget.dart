import 'package:flutter/material.dart';

import '../../../../core/constants/app_consts.dart';
import '../../../../core/extensions/app_paddings.dart';
import '../../../../data/models/task.dart';

class ChipLabelWidget extends StatelessWidget {
  const ChipLabelWidget({
    super.key,
    required this.tasks,
    required this.index,
    required this.selectedIndex,
  });

  final List<Task> tasks;
  final int index;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Text(
            'tasks[$index].statusName',
            style: TextStyle(
              color: selectedIndex == index ? Colors.white : AppColors.primary,
              fontWeight: FontWeight.w900,
              fontSize: 18,
            ),
          ),
          10.wGap,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.redAccent,
              // tasks[index].color.toColor(),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                // '${tasks[index].taskCount}',
                index.toString(),
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

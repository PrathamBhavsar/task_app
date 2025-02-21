import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../utils/constants/app_consts.dart';
import '../../../../utils/extensions/app_paddings.dart';

class ChipLabelWidget extends StatelessWidget {
  const ChipLabelWidget({
    super.key,
    required this.categories,
    required this.index,
    required this.selectedIndex,
    required this.taskCounts,
  });

  final List<String> categories;
  final List<int> taskCounts;
  final int index;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Text(
            categories[index],
            style: TextStyle(
              color: selectedIndex == index ? Colors.white : AppColors.primary,
              fontWeight: FontWeight.w900,
              fontSize: 18,
            ),
          ),
          10.wGap,
          Skeleton.ignore(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.green,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  taskCounts[index].toString(),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
              ).padSymmetric(horizontal: 8, vertical: 3),
            ),
          ),
        ],
      );
}

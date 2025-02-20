import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../data/models/task.dart';
import '../../../../../data/models/taskWithUser.dart';
import '../../../../../utils/constants/app_consts.dart';
import '../../../../../utils/extensions/app_paddings.dart';
import '../../../../providers/task_provider.dart';
import '../../../task/widgets/chip_label_widget.dart';
import 'widgets/task_list.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({super.key});

  @override
  Widget build(BuildContext context) => Consumer<TaskProvider>(
        builder: (BuildContext context, TaskProvider provider, Widget? child) {
          final Map<String, List<TaskWithUsers>> categorizedTasks =
              provider.categorizedTasks;
          final List<String> categories = categorizedTasks.keys.toList();
          final List<int> taskCounts = categories
              .map((category) => categorizedTasks[category]!.length)
              .toList();

          return Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    categories.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        showCheckmark: false,
                        label: ChipLabelWidget(
                          categories: categories,
                          taskCounts: taskCounts,
                          index: index,
                          selectedIndex: provider.selectedListIndex,
                        ),
                        selectedColor: AppColors.primary,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                          side: BorderSide(
                            color: provider.selectedListIndex == index
                                ? Colors.transparent
                                : AppColors.primary,
                            width: 2,
                          ),
                        ),
                        selected: provider.selectedListIndex == index,
                        onSelected: (bool selected) {
                          provider.updateSelectedListIndex(index);
                        },
                      ),
                    ),
                  ),
                ).padSymmetric(horizontal: 8),
              ),
              Expanded(
                child: IndexedStack(
                  index: provider.selectedListIndex,
                  children: categories.map((category) {
                    final List<TaskWithUsers> tasks =
                        categorizedTasks[category] ?? [];
                    return TasksList(
                      tasksList: tasks,
                      altText: 'No tasks in $category',
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        },
      );
}

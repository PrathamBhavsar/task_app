import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/constants/app_consts.dart';

import '../../../../../data/models/task.dart';

import '../../../../providers/task_provider.dart';
import '../../../task/widgets/chip_label_widget.dart';
import 'widgets/task_list.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({super.key});

  @override
  Widget build(BuildContext context) => Consumer<TaskProvider>(
        builder: (BuildContext context, TaskProvider provider, Widget? child) {
          // final user = snapshot.data!;
          // final user = UserModel(
          //   name: 'Bhushan',
          //   role: UserRole.agency,
          //   email: 'a@gmail.com',
          //   profileBgColor: 'ff358845',
          // );

          // final List<Map<String, dynamic>> _tabs =
          //     provider.getTabsForRole(user.role, provider.fetchedData);

          // final List<Map<String, dynamic>> tabs = provider.getTabsForRole(
          //   user.role,
          //   DummyData.dummyFetchedDataProvider,
          // );

          final List<Task> taskList = provider.allTasks;

          return Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: List.generate(
                      taskList.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          showCheckmark: false,
                          label: ChipLabelWidget(
                            tasks: taskList,
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
                            provider.setSelectedListIndex(index);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: IndexedStack(
                  index: provider.selectedListIndex,
                  children: taskList
                      .map((task) => TasksList1(
                            tasksList: [task],
                            altText: 'No ${task.id} Tasks',
                          ))
                      .toList(),
                ),
              ),
            ],
          );
        },
      );
}

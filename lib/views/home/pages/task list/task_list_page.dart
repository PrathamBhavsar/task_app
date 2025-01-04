import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:task_app/constants/app_colors.dart';
import 'package:task_app/controllers/auth_controller.dart';
import 'package:task_app/providers/task_provider.dart';
import 'package:task_app/views/home/pages/task%20list/widgets/complete_tasks/complete_tasks_list.dart';
import 'package:task_app/views/home/pages/task%20list/widgets/shared_tasks/shared_tasks_list.dart';
import 'package:task_app/views/home/pages/task%20list/widgets/pending_tasks/pending_tasks_list.dart';
import 'package:task_app/views/home/pages/widgets/chip_label_widget.dart';
import 'package:task_app/widgets/circle_icons.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (BuildContext context, TaskProvider provider, Widget? child) {
        final pendingTasksList = provider.fetchedData['pending_tasks'];
        final sharedTasksList = provider.fetchedData['shared_tasks'];
        final completedTasksList = provider.fetchedData['completed_tasks'];

        final List<Map<String, dynamic>> _tabs = [
          {
            'label': 'Pending',
            'count': pendingTasksList?.length ?? 0,
            'color': AppColors.pink
          },
          {
            'label': 'Shared',
            'count': sharedTasksList?.length ?? 0,
            'color': AppColors.orange
          },
          {
            'label': 'Complete',
            'count': completedTasksList?.length ?? 0,
            'color': AppColors.green
          },
        ];

        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () => context.push('/taskDetails?isNewTask=true'),
          ),
          appBar: AppBar(
            forceMaterialTransparency: true,
            title: const Text(
              'Task List',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: CircleIcons(
                  icon: Icons.notifications_none_rounded,
                  onTap: () {
                    AuthController.instance.logout(context);
                  },
                ),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _tabs.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          showCheckmark: false,
                          label: ChipLabelWidget(
                            tabs: _tabs,
                            index: index,
                            selectedIndex: provider.selectedListIndex,
                          ),
                          selected: provider.selectedListIndex == index,
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
                          onSelected: (bool selected) {
                            provider.setSelectedListIndex(index);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: IndexedStack(
            index: provider.selectedListIndex,
            children: [
              PendingTasksList(
                pendingTasksList: pendingTasksList ?? [],
              ),
              SharedTasksList(
                sharedTasksList: sharedTasksList ?? [],
              ),
              CompleteTasksList(
                completedTasksList: completedTasksList ?? [],
              ),
            ],
          ),
        );
      },
    );
  }
}

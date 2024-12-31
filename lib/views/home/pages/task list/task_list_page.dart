import 'package:flutter/material.dart';
import 'package:task_app/constants/app_colors.dart';
import 'package:task_app/views/home/pages/task%20list/widgets/complete_tasks/complete_tasks_list.dart';
import 'package:task_app/views/home/pages/task%20list/widgets/in_review_tasks_list.dart';
import 'package:task_app/views/home/pages/task%20list/widgets/todo_tasks_list.dart';
import 'package:task_app/views/home/pages/widgets/chip_label_widget.dart';
import 'package:task_app/widgets/circle_icons.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _tabs = [
    {'label': 'Complete', 'count': 40, 'color': AppColors.green},
    {'label': 'To Do', 'count': 12, 'color': AppColors.textFieldBg},
    {'label': 'In Review', 'count': 99, 'color': AppColors.orange},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              onTap: () {},
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
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
                        selectedIndex: _selectedIndex,
                      ),
                      selected: _selectedIndex == index,
                      selectedColor: AppColors.primary,
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                        side: BorderSide(
                          color: _selectedIndex == index
                              ? Colors.transparent
                              : AppColors.primary,
                          width: 2,
                        ),
                      ),
                      onSelected: (bool selected) {
                        setState(() {
                          _selectedIndex = index;
                        });
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
        index: _selectedIndex,
        children: const [
          CompleteTasksList(),
          ToDoTasksList(),
          InReviewTasksList(),
        ],
      ),
    );
  }
}

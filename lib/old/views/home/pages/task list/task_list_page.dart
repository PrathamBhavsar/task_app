import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/constants/app_consts.dart';

import '../../../../../core/constants/dummy_data.dart';
import '../../../../../core/constants/enums.dart';
import '../../../../models/user.dart';
import '../../../../providers/task_provider.dart';
import 'widgets/task_list.dart';
import '../widgets/chip_label_widget.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({super.key});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  late Future<UserModel?> _userFuture;

  @override
  void initState() {
    super.initState();
    // _userFuture = AuthController.instance.getLoggedInUser();
    // _userFuture.then((user) {
    //   if (user != null) {
    //     TaskProvider.instance.setCurrentUser(user);
    //   }
    // });
    _userFuture = Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<UserModel?>(
        future: _userFuture,
        builder: (context, snapshot) {
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return const Center(child: CircularProgressIndicator());
          // }
          //
          // if (!snapshot.hasData) {
          //   return const Center(
          //     child: Text("No user found"),
          //   );
          // }

          return Consumer<TaskProvider>(
            builder:
                (BuildContext context, TaskProvider provider, Widget? child) {
              // final user = snapshot.data!;
              final user = UserModel(
                name: 'Bhushan',
                role: UserRole.agency,
                email: 'a@gmail.com',
                profileBgColor: 'ff358845',
              );

              // final List<Map<String, dynamic>> _tabs =
              //     provider.getTabsForRole(user.role, provider.fetchedData);

              final List<Map<String, dynamic>> tabs = provider.getTabsForRole(
                user.role,
                DummyData.dummyFetchedDataProvider,
              );

              return Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(
                          tabs.length,
                          (index) => Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ChoiceChip(
                              showCheckmark: false,
                              label: ChipLabelWidget(
                                tabs: tabs,
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
                      children: tabs.map((tab) {
                        // final taskList = provider.fetchedData[tab['key']] ?? [];

                        final List<Map<String, dynamic>> taskList =
                            DummyData.dummyFetchedData[tab['key']] ?? [];

                        return TasksList(
                          tasksList: taskList,
                          noListText: 'No ${tab['label']} Tasks',
                          isSalesperson:
                              user.role == UserRole.salesperson ?? false,
                        );
                      }).toList(),
                    ),
                  ),
                ],
              );
            },
          );
        },
      );
}

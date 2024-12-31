import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/constants/app_colors.dart';
import 'package:task_app/providers/task_provider.dart';

class UserModal extends StatefulWidget {
  const UserModal(
      {super.key,
      required this.textController,
      required this.title,
      required this.table});
  final TextEditingController textController;
  final String title;
  final String table;
  @override
  State<UserModal> createState() => _UserModalState();
}

class _UserModalState extends State<UserModal> {
  final FocusNode searchFocusNode = FocusNode();
  final TextEditingController searchController = TextEditingController();
  final List<Map<String, dynamic>> selectedUsersTemp = [];

  @override
  void initState() {
    super.initState();
    TaskProvider.instance.getUsers(widget.table);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);

    return FractionallySizedBox(
      heightFactor: 0.7,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    switch (widget.table) {
                      case 'salesperson':
                        provider.addAssignees(
                            selectedUsersTemp, widget.textController);
                        break;
                      case 'designer':
                        provider.addDesigners(
                            selectedUsersTemp, widget.textController);
                        break;
                      case 'client':
                        provider.addClients(
                            selectedUsersTemp, widget.textController);
                        break;
                      default:
                        throw Exception("Invalid table name: ${widget.table}");
                    }

                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Done',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Search Field
            TextField(
              focusNode: searchFocusNode,
              controller: searchController,
              decoration: const InputDecoration(
                isDense: true,
                hintText: 'Search Here',
                prefixIcon: Icon(Icons.search_rounded),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: provider.userNames.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: provider.userNames.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> userName =
                            provider.userNames[index];
                        bool isSelected = selectedUsersTemp.contains(userName);
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                selectedUsersTemp.remove(userName); // Deselect
                              } else {
                                selectedUsersTemp.add(userName); // Select
                              }
                            });
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const SizedBox(width: 12),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? AppColors.green
                                          : AppColors.orange,
                                      shape: BoxShape.circle,
                                    ),
                                    height: 40,
                                    width: 40,
                                    child: isSelected
                                        ? const Icon(
                                            Icons.done_rounded,
                                            color: Colors.white,
                                          )
                                        : null,
                                  ),
                                  const SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        userName['name'],
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                      const Text('Tasks: 10'),
                                    ],
                                  ),
                                ],
                              ),
                              const Divider(),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

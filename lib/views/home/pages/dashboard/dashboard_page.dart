import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:task_app/constants/app_colors.dart';
import 'package:task_app/controllers/auth_controller.dart';
import 'package:task_app/models/user.dart';
import 'package:task_app/providers/task_provider.dart';
import 'package:task_app/views/home/pages/task%20list/widgets/task_list.dart';
import 'package:task_app/views/home/pages/widgets/chip_label_widget.dart';
import 'package:task_app/widgets/circle_icons.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Future<UserModel?> _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = AuthController.instance.getLoggedInUser();
    _userFuture.then((user) {
      if (user != null) {
        TaskProvider.instance.setCurrentUser(user);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel?>(
      future: _userFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData) {
          return const Center(
            child: Text("No user found"),
          );
        }

        return Consumer<TaskProvider>(
          builder:
              (BuildContext context, TaskProvider provider, Widget? child) {
            final user = snapshot.data!;

            final List<Map<String, dynamic>> _tabs =
                provider.getTabsForRole(user.role, provider.fetchedData);

            return Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () => context.push('/taskDetails?isNewTask=true'),
              ),
              appBar: AppBar(
                title: const Text(
                  'Dashboard',
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
              ),
              body: Padding(
                padding: AppPaddings.appPadding,
                child: Column(
                  children: [],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

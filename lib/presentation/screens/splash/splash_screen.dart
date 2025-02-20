import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../data/models/client.dart';
import '../../../data/models/designer.dart';
import '../../../data/models/priority.dart';
import '../../../data/models/status.dart';
import '../../../data/models/user.dart';
import '../../providers/home_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<HomeProvider>(context, listen: false)
          .fetchAllData()
          .then((value) {
        if (mounted) {
          context.pushNamed('home');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Splash")),
      body: provider.isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: provider.users.length,
                    itemBuilder: (context, index) {
                      final User user = provider.users[index];
                      return ListTile(
                        subtitle: Text(user.name),
                      );
                    },
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: provider.priorities.length,
                    itemBuilder: (context, index) {
                      final Priority priority = provider.priorities[index];
                      return ListTile(
                        subtitle: Text(priority.name),
                      );
                    },
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: provider.statuses.length,
                    itemBuilder: (context, index) {
                      final Status status = provider.statuses[index];
                      return ListTile(
                        subtitle: Text(status.name),
                      );
                    },
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: provider.clients.length,
                    itemBuilder: (context, index) {
                      final Client client = provider.clients[index];
                      return ListTile(
                        subtitle: Text(client.name),
                      );
                    },
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: provider.designers.length,
                    itemBuilder: (context, index) {
                      final Designer designer = provider.designers[index];
                      return ListTile(
                        subtitle: Text(designer.name),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}

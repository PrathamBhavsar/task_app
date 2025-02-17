import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/status.dart';
import '../providers/status_provider.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StatusProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Status")),
      body: provider.isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: provider.statuses.length,
              itemBuilder: (context, index) {
                final Status user = provider.statuses[index];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.category),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: provider.fetchStatuses,
        child: Icon(Icons.refresh),
      ),
    );
  }
}

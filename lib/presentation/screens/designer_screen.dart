import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/priority.dart';
import '../providers/priority_provider.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PriorityProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Priority")),
      body: provider.isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: provider.priorities.length,
              itemBuilder: (context, index) {
                final Priority user = provider.priorities[index];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.color),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: provider.fetchPriorities,
        child: Icon(Icons.refresh),
      ),
    );
  }
}

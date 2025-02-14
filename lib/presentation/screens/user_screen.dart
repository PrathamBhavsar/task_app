import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/user.dart';
import '../providers/user_provider.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Products")),
      body: provider.isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: provider.users.length,
              itemBuilder: (context, index) {
                final User user = provider.users[index];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.role),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: provider.fetchUsers,
        child: Icon(Icons.refresh),
      ),
    );
  }
}

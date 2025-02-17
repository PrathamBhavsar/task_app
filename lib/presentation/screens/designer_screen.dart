import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/client.dart';
import '../providers/client_provider.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ClientProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Client")),
      body: provider.isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: provider.clients.length,
              itemBuilder: (context, index) {
                final Client user = provider.clients[index];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.address),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: provider.fetchClients,
        child: Icon(Icons.refresh),
      ),
    );
  }
}

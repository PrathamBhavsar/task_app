import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/designer.dart';
import '../../data/models/user.dart';
import '../providers/designer_provider.dart';
import '../providers/user_provider.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DesignerProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Designer")),
      body: provider.isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: provider.designers.length,
              itemBuilder: (context, index) {
                final Designer user = provider.designers[index];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.firmName),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: provider.fetchDesigners,
        child: Icon(Icons.refresh),
      ),
    );
  }
}

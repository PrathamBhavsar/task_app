import 'package:flutter/material.dart';
import 'package:task_app/views/task/widgets/user_modal.dart';

void showClientsBottomSheet(BuildContext context,
    List<Map<String, dynamic>> list, String name, String nameKey) {
  showModalBottomSheet(
    showDragHandle: true,
    context: context,
    builder: (context) {
      return ClientsBottomSheetWidget(
        list: list,
        name: name,
        nameKey: nameKey,
      );
    },
  );
}

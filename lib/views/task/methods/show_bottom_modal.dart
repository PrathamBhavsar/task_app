import 'package:flutter/material.dart';
import '../widgets/user_modal.dart';

void showClientsBottomSheet(BuildContext context,
    List<Map<String, dynamic>> list, String name, String indexKey) {
  showModalBottomSheet(
    showDragHandle: true,
    context: context,
    builder: (context) => ClientsBottomSheetWidget(
        list: list,
        name: name,
        indexKey: indexKey,
      ),
  );
}

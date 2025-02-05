import 'package:flutter/material.dart';
import '../widgets/custom_modal_widget.dart';

void showClientsBottomSheet(
  BuildContext context,
  List<Map<String, dynamic>> list,
  String name,
  String indexKey,
  bool? isStatus,
) {
  showModalBottomSheet(
    showDragHandle: true,
    context: context,
    builder: (context) => CustomBottomSheetWidget(
      list: list,
      name: name,
      indexKey: indexKey,
      isStatus: isStatus ?? false,
    ),
  );
}

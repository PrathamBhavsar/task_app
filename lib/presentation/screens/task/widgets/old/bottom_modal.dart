import 'package:flutter/material.dart';
import 'custom_modal_widget.dart';

void showClientsBottomSheet(
  BuildContext context,
  List<dynamic> list,
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

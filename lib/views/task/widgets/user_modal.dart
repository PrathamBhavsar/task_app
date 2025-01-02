import 'package:flutter/material.dart';
import 'package:task_app/constants/app_colors.dart';
import 'package:task_app/providers/task_provider.dart';
import 'package:task_app/widgets/custom_tag.dart';

class ClientsBottomSheetWidget extends StatelessWidget {
  final List<Map<String, dynamic>> list;
  final String name;
  final String nameKey;

  const ClientsBottomSheetWidget(
      {Key? key, required this.list, required this.name, required this.nameKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: AppTexts.headingStyle,
          ),
          AppPaddings.gapH(10),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: list.map((client) {
              final name = client[nameKey];
              final Color color =
                  TaskProvider.instance.stringToColor(client['color']);
              return CustomTag(
                color: color,
                text: name,
              );
            }).toList(),
          ),
          AppPaddings.gapH(20),
        ],
      ),
    );
  }
}

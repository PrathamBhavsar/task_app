import 'package:flutter/material.dart';
import 'package:task_app/constants/app_colors.dart';
import 'package:task_app/widgets/custom_tag.dart';

class ClientNameDropdown extends StatelessWidget {
  const ClientNameDropdown(
      {super.key,
      required this.name,
      required this.clientList,
      required this.onTap});
  final String name;
  final List<Map<String, dynamic>> clientList;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Client Name',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(fontSize: 22, fontWeight: AppTexts.fW900),
              ),
              AppPaddings.gapW(8),
              Icon(Icons.arrow_drop_down_rounded)
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:task_app/constants/app_colors.dart';

class ClientNameDropdown extends StatelessWidget {
  const ClientNameDropdown(
      {super.key,
      required this.name,
      required this.clientList,
      required this.onTap,
      required this.dealNo,
      required this.isNewTask});
  final String name;
  final List<Map<String, dynamic>> clientList;
  final void Function() onTap;
  final String dealNo;
  final bool isNewTask;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
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
                    style: TextStyle(fontSize: 22, fontWeight: AppTexts.fW700),
                  ),
                  AppPaddings.gapW(8),
                  Icon(Icons.arrow_drop_down_rounded)
                ],
              ),
            ],
          ),
          !isNewTask
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Deal No',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      dealNo,
                      style:
                          TextStyle(fontSize: 22, fontWeight: AppTexts.fW700),
                    ),
                  ],
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:task_app/constants/app_colors.dart';

class ClientNameDropdown extends StatelessWidget {
  const ClientNameDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Client Name',
              style: TextStyle(fontSize: 22, fontWeight: AppTexts.fW900),
            ),
            AppPaddings.gapW(8),
            Icon(Icons.arrow_drop_down_rounded)
          ],
        ),
        Text(
          'Client Name',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        )
      ],
    );
  }
}

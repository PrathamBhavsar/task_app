import 'package:flutter/material.dart';
import 'package:task_app/constants/app_colors.dart';

class CustomPickerFeild extends StatelessWidget {
  const CustomPickerFeild({
    super.key,
    required this.text,
    required this.onTap,
  });
  final String text;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        child: Row(
          children: [
            Container(
              width: 60,
              decoration: BoxDecoration(
                color: AppColors.orange,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Icon(Icons.calendar_month_rounded),
              ),
            ),
            AppPaddings.gapW(20),
            Text(
              text,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:task_app/constants/app_colors.dart';

class CustomTag extends StatelessWidget {
  const CustomTag({super.key, required this.color, required this.text});
  final Color color;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(width: 2),
        borderRadius: BorderRadius.circular(25),
        color: color,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: AppTexts.fW900,
          color: AppColors.primary,
        ),
      ),
    );
  }
}

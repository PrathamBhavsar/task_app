import 'package:flutter/material.dart';
import 'package:task_app/constants/app_colors.dart';

class UserRoleTile extends StatelessWidget {
  const UserRoleTile({
    super.key,
    required this.text,
    required this.onTap,
    required this.isSelected,
  });

  final String text;
  final Function() onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 2,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? AppColors.green : Colors.white,
            border: Border.all(width: 2),
            borderRadius: AppTexts.borderRadius,
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

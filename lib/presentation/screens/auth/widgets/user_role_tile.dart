import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../utils/constants/app_constants.dart';

class UserRoleTile extends StatelessWidget {
  const UserRoleTile({
    required this.text, required this.onTap, required this.isSelected, super.key,
  });

  final String text;
  final Function() onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) => Flexible(
    flex: 2,
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          border: Border.all(width: 1.w, color: AppColors.accent),
          borderRadius: AppBorders.radius,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16.sp,
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    ),
  );
}

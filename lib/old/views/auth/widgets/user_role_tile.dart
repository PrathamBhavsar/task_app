import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_consts.dart';

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
  Widget build(BuildContext context) => Flexible(
        flex: 2,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? AppColors.green : Colors.white,
              border: Border.all(width: 2.w),
              borderRadius: AppBorders.radius,
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      );
}

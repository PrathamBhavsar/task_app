import 'package:flutter/material.dart';
import '../../core/constants/app_consts.dart';
import '../extensions/app_paddings.dart';

class CustomPickerFeild extends StatelessWidget {
  const CustomPickerFeild({
    super.key,
    required this.text,
    required this.onTap,
  });
  final String text;
  final Function() onTap;
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: SizedBox(
          height: 60,
          child: Row(
            children: [
              Container(
                width: 60,
                decoration: BoxDecoration(
                  color: AppColors.orange,
                  borderRadius: AppBorders.radius,
                ),
                child: Center(
                  child: Icon(Icons.calendar_month_rounded),
                ),
              ),
              20.wGap,
              Text(
                text,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
              )
            ],
          ),
        ),
      );
}

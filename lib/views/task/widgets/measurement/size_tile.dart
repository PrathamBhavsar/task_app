import 'package:flutter/material.dart';
import 'package:task_app/constants/app_colors.dart';

class WindowTile extends StatelessWidget {
  WindowTile(
      {super.key,
      required this.windowName,
      required this.size,
      required this.windowArea,
      required this.windowType,
      required this.windowRemark});
  final String windowName;
  final String windowArea;
  final String windowType;
  final String windowRemark;
  final String size;

  TextStyle textStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.w500);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              windowName,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
            ),
            Text(
              size,
              style: textStyle,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Area',
              style: textStyle,
            ),
            Text(
              "$windowArea mtr",
              style: textStyle,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Type',
              style: textStyle,
            ),
            Text(
              windowType,
              style: textStyle,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Remark',
              style: textStyle,
            ),
            Text(
              windowRemark,
              style: textStyle,
            ),
          ],
        ),
        AppPaddings.gapH(5)
      ],
    );
  }
}

import 'package:flutter/material.dart';

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

  TextStyle textStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              windowName,
              style: textStyle,
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
              windowArea,
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
      ],
    );
  }
}

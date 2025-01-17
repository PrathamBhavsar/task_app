import 'package:flutter/material.dart';

class WindowTile extends StatelessWidget {
  const WindowTile({super.key, required this.windowName, required this.size});
  final String windowName;
  final String size;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          windowName,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Text(
          size,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

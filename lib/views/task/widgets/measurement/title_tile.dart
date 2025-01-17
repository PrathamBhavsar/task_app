import 'package:flutter/material.dart';

class TitleTile extends StatelessWidget {
  const TitleTile({super.key, required this.roomName});
  final String roomName;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          roomName,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
      ],
    );
  }
}

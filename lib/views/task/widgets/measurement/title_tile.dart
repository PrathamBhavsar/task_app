import 'package:flutter/material.dart';

class TitleTile extends StatelessWidget {
  const TitleTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Room 1',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
        Text(
          'Size',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
      ],
    );
  }
}

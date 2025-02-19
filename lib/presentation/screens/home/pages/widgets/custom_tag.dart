import 'package:flutter/material.dart';

class CustomTag extends StatelessWidget {
  const CustomTag({
    super.key,
    required this.color,
    required this.text,
    this.isSelected = false,
  });

  final Color color;
  final String text;
  final bool isSelected;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(width: 2),
          borderRadius: BorderRadius.circular(25),
          color: isSelected ? Colors.black : color,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
            if (isSelected)
              Padding(
                padding: const EdgeInsets.only(left: 6),
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 16,
                ),
              )
          ],
        ),
      );
}

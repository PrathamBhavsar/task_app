import 'package:flutter/material.dart';

class CircleIcons extends StatelessWidget {
  const CircleIcons({
    super.key,
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 2),
        ),
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Icon(
            icon,
            size: 24,
          ),
        ),
      ),
    );
}

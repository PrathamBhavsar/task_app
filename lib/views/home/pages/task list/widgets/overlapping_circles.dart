import 'package:flutter/material.dart';
import 'dart:math';

class OverlappingCircles extends StatelessWidget {
  final int numberOfCircles;

  const OverlappingCircles({super.key, required this.numberOfCircles});

  @override
  Widget build(BuildContext context) {
    final random = Random();
    List<Color> randomColors = List.generate(
      numberOfCircles,
      (_) => Color.fromRGBO(
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
        1.0,
      ),
    );

    return Stack(
      children: List.generate(
        numberOfCircles,
        (index) {
          final overlapOffset = index * 20.0; // Adjust overlap amount
          return Positioned(
            left: overlapOffset,
            child: CircleAvatar(
              radius: 25,
              backgroundColor: randomColors[index],
              child: index == numberOfCircles - 1
                  ? Text(
                      '+${numberOfCircles - index}',
                      style: const TextStyle(color: Colors.white),
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }
}

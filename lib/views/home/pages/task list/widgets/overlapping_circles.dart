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

    final totalWidth = 16.0 * 2 + (numberOfCircles - 1) * 12.0;

    return SizedBox(
      width: totalWidth,
      height: 32.0,
      child: Stack(
        children: List.generate(
          numberOfCircles,
          (index) {
            final overlapOffset = index * 12.0;
            return Positioned(
              left: overlapOffset,
              child: CircleAvatar(
                radius: 16,
                backgroundColor: randomColors[index],
                child: index == numberOfCircles - 1
                    ? Text(
                        '+${numberOfCircles - index}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                        ),
                      )
                    : null,
              ),
            );
          },
        ),
      ),
    );
  }
}

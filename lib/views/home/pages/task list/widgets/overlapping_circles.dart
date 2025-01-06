import 'package:flutter/material.dart';
import 'dart:math';

class OverlappingCircles extends StatelessWidget {
  final int numberOfCircles;

  const OverlappingCircles({super.key, required this.numberOfCircles});

  @override
  Widget build(BuildContext context) {
    final random = Random();

    // Generate random colors for the circles
    List<Color> randomColors = List.generate(
      numberOfCircles,
      (_) => Color.fromRGBO(
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
        1.0,
      ),
    );

    final circlesToShow = numberOfCircles > 3 ? 2 : numberOfCircles;
    final remainingCircles = numberOfCircles - 3;

    double textWidth = 0.0;
    if (remainingCircles > 0) {
      final textPainter = TextPainter(
        text: TextSpan(
          text: '+$remainingCircles',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w900,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      textWidth = textPainter.width;
    }

    final totalWidth = 16.0 * 2 +
        (circlesToShow - 1) * 12.0 +
        (remainingCircles > 0 ? max(16.0, textWidth) : 0);

    return SizedBox(
      width: totalWidth,
      height: 32.0,
      child: Stack(
        children: List.generate(
          circlesToShow + (remainingCircles > 0 ? 1 : 0),
          (index) {
            final overlapOffset = index * 12.0;

            if (remainingCircles > 0 && index == circlesToShow) {
              return Positioned(
                left: overlapOffset,
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.grey,
                  child: Text(
                    '+$remainingCircles',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              );
            }

            return Positioned(
              left: overlapOffset,
              child: CircleAvatar(
                radius: 16,
                backgroundColor: randomColors[index],
              ),
            );
          },
        ),
      ),
    );
  }
}

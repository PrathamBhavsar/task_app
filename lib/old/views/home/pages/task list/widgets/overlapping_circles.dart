import 'package:flutter/material.dart';
import 'dart:math';

import '../../../../../../core/constants/app_consts.dart';

class OverlappingCircles extends StatelessWidget {
  final List<Color> bgColors;
  final List<String> displayNames;
  final double circleSize;
  final double borderWidth;
  final Color borderColor;

  const OverlappingCircles({
    super.key,
    required this.bgColors,
    required this.displayNames,
    this.circleSize = 38.0,
    this.borderWidth = 2.0,
    this.borderColor = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    final numberOfCircles = min(bgColors.length, displayNames.length);
    final circlesToShow = numberOfCircles > 3 ? 2 : numberOfCircles;
    final remainingCircles = numberOfCircles - 3;
    final fontSize = circleSize * 0.4;

    // Calculate width for the "+remainingCircles" text
    double textWidth = 0.0;
    if (remainingCircles > 0) {
      final textPainter = TextPainter(
        text: TextSpan(
          text: '+$remainingCircles',
          style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w900,
              color: AppColors.primary),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      textWidth = textPainter.width;
    }
    final space = circleSize * 0.7;
    final totalWidth = circleSize +
        (circlesToShow - 1) * space +
        (remainingCircles > 0 ? max(circleSize, textWidth) : 0);

    return SizedBox(
      width: totalWidth,
      height: circleSize,
      child: Stack(
        children: List.generate(
          circlesToShow + (remainingCircles > 0 ? 1 : 0),
          (index) {
            final overlapOffset = index * space;

            if (remainingCircles > 0 && index == circlesToShow) {
              return Positioned(
                left: overlapOffset,
                child: Container(
                  width: circleSize,
                  height: circleSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: borderColor,
                      width: borderWidth,
                    ),
                    color: Colors.grey,
                  ),
                  child: Center(
                    child: Text(
                      '+$remainingCircles',
                      style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.w900,
                          color: AppColors.primary),
                    ),
                  ),
                ),
              );
            }

            // Display the first two letters of the display name
            final initials = displayNames[index]
                .trim()
                .split(' ')
                .map((word) => word.isNotEmpty ? word[0] : '')
                .take(2)
                .join();

            return Positioned(
              left: overlapOffset,
              child: Container(
                width: circleSize,
                height: circleSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: borderColor,
                    width: borderWidth,
                  ),
                  color: bgColors[index],
                ),
                child: Center(
                  child: Text(
                    initials,
                    style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

extension Spacing on num {
  SizedBox get hGap => SizedBox(height: toDouble());
  SizedBox get wGap => SizedBox(width: toDouble());
}

extension PaddingExtensions on Widget {
  Padding padAll(double value) =>
      Padding(padding: EdgeInsets.all(value), child: this);
  Padding padSymmetric({double vertical = 0, double horizontal = 0}) => Padding(
    padding: EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
    child: this,
  );
}

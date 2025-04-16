// Place fonts/CustomIcon.ttf in your fonts/ directory and
// add the following to your pubspec.yaml
// flutter:
//   fonts:
//    - family: CustomIcon
//      fonts:
//       - asset: fonts/CustomIcon.ttf
import 'package:flutter/widgets.dart';

class CustomIcon {
  CustomIcon._();

  static const String _fontFamily = 'CustomIcons';

  static const IconData calendar = IconData(0xe910, fontFamily: _fontFamily);
  static const IconData layout = IconData(0xe911, fontFamily: _fontFamily);
  static const IconData badgePlus = IconData(0xe900, fontFamily: _fontFamily);
  static const IconData chevronRight = IconData(
    0xe901,
    fontFamily: _fontFamily,
  );
  static const IconData circleCheckBig = IconData(
    0xe902,
    fontFamily: _fontFamily,
  );
  static const IconData clipboardList = IconData(
    0xe903,
    fontFamily: _fontFamily,
  );
  static const IconData clock4 = IconData(0xe904, fontFamily: _fontFamily);
  static const IconData cloudUpload = IconData(0xe905, fontFamily: _fontFamily);
  static const IconData eye = IconData(0xe906, fontFamily: _fontFamily);
  static const IconData menu = IconData(0xe907, fontFamily: _fontFamily);
  static const IconData messageSquare = IconData(
    0xe908,
    fontFamily: _fontFamily,
  );
  static const IconData packageOpen = IconData(0xe909, fontFamily: _fontFamily);
  static const IconData package = IconData(0xe90a, fontFamily: _fontFamily);
  static const IconData phone = IconData(0xe90b, fontFamily: _fontFamily);
  static const IconData receiptIndianRupee = IconData(
    0xe90c,
    fontFamily: _fontFamily,
  );
  static const IconData search = IconData(0xe90d, fontFamily: _fontFamily);
  static const IconData squarePen = IconData(0xe90e, fontFamily: _fontFamily);
  static const IconData users = IconData(0xe90f, fontFamily: _fontFamily);
}

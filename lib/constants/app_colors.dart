import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppColors {
  static const Color textFieldBg = Color(0xfff7f7f7);
  static const Color green = Color(0xff5cd669);
  static const Color darkGreen = Color(0xffe8a4fe);
  static const Color primary = Color(0xff181818);
  static const Color accent = Color(0xffb4b4b4);
  static const Color error = Color(0xffffecec);
  static const Color purple = Color(0xff9d9bff);
  static const Color lightBlue = Color(0xff85C1E9);
  static const Color orange = Color(0xfff6bb54);
  static const Color pink = Color(0xffe8a4fe);

  static const Color pdfRed = Color(0xfffdeeee);
  static const Color jpgBlue = Color(0xffe6effa);
  static const Color defaultColor = Color(0xfff0f0f0);

  // Create a MaterialColor from the primary color
  static final MaterialColor primarySwatch = createMaterialColor(primary);

  // Helper function to create a MaterialColor
  static MaterialColor createMaterialColor(Color color) {
    Map<int, Color> colorShades = {
      50: Color.alphaBlend(Colors.white.withOpacity(0.9), color),
      100: Color.alphaBlend(Colors.white.withOpacity(0.8), color),
      200: Color.alphaBlend(Colors.white.withOpacity(0.6), color),
      300: Color.alphaBlend(Colors.white.withOpacity(0.4), color),
      400: Color.alphaBlend(Colors.white.withOpacity(0.2), color),
      500: color,
      600: Color.alphaBlend(Colors.black.withOpacity(0.1), color),
      700: Color.alphaBlend(Colors.black.withOpacity(0.2), color),
      800: Color.alphaBlend(Colors.black.withOpacity(0.3), color),
      900: Color.alphaBlend(Colors.black.withOpacity(0.4), color),
    };

    return MaterialColor(color.value, colorShades);
  }
}

class AppPaddings {
  static EdgeInsets appPadding = const EdgeInsets.all(10);

  static Widget gapH(double h) => SizedBox(height: h);
  static Widget gapW(double w) => SizedBox(width: w);
}

class AppTexts {
  static var borderWidth = Border.all(width: 2);

  static TextStyle headingStyle = TextStyle(
    fontSize: 22.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle appBarStyle = TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeight.bold,
  );

  static TextStyle tileSubtitle = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
  );
  static TextStyle tileTitle2 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w700,
  );
  static TextStyle tileHeading = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
  );
  static TextStyle tileTitle1 = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
  );

  static TextStyle buttonText = TextStyle(
    fontSize: 22.sp,
    fontWeight: FontWeight.w900,
  );

  static TextStyle inputTextStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );

  static TextStyle inputLabelTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );

  static TextStyle inputHintTextStyle = TextStyle(
    color: AppColors.accent,
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );
}

class AppBorders {
  static var radius = BorderRadius.circular(15);

  static OutlineInputBorder outlineTFBorder(BorderSide borderSide) =>
      OutlineInputBorder(
        borderSide: borderSide,
        borderRadius: radius,
      );
}

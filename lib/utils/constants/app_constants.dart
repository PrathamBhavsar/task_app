import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppColors {
  static const Color primary = Color(0xffa18ef4);
  static const Color secondary = Color(0xff171625);
  static const Color accent = Color(0xffdedede);
  static const Color bgYellow = Color(0xfffffbeb);
  static const Color lighterBlackBg = Colors.grey;

  static const Color errorRed = Color(0xffff8a81);
  static const Color darkBlueText = Color(0xff3b82f6);
  static const Color darkYellowText = Color(0xff92400e);
  static const Color blueBg = Color(0xffeff6ff);
  static const Color green = Color(0xff66bb6a);
  static const Color lighterGreenBg = Color(0xfff0fdf4);
  static const Color darkGreenText = Color(0xff166533);
}

abstract class AppPaddings {
  static double appPaddingInt = 10;
}

abstract class AppBorders {
  static var radius = BorderRadius.circular(10);

  static OutlineInputBorder outlineTFBorder(BorderSide borderSide) =>
      OutlineInputBorder(borderSide: borderSide, borderRadius: radius);
}

abstract class AppTexts {
  static TextStyle titleTextStyle = TextStyle(
    fontSize: 20.sp,
    fontVariations: [FontVariation.weight(800)],
  );

  static TextStyle headingTextStyle = TextStyle(
    fontSize: 16.sp,
    fontVariations: [FontVariation.weight(500)],
  );

  static TextStyle subtitleTextStyle = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
  );

  static TextStyle dataTextStyle = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w900,
  );

  static TextStyle modalTitleTextStyle = TextStyle(
    fontSize: 22.sp,
    fontWeight: FontWeight.bold,
  );

  static TextStyle labelTextStyle = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.bold,
  );

  static TextStyle inputTextStyle = TextStyle(
    fontSize: 14.sp,
    color: Colors.black,
  );

  static TextStyle inputLabelTextStyle = TextStyle(fontSize: 14.sp);

  static TextStyle inputHintTextStyle = TextStyle(
    color: Colors.grey,
    fontSize: 14.sp,
  );
}

abstract class AppThemes {
  static ThemeData themeData = ThemeData(
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.black,
      selectionColor: AppColors.accent,
      selectionHandleColor: Colors.black,
    ),
    iconTheme: IconThemeData(color: AppColors.accent),
    fontFamily: 'Inter',
    splashColor: Colors.black.withAlpha(2),
    inputDecorationTheme: InputDecorationTheme(focusColor: Colors.black),
    appBarTheme: AppBarTheme(backgroundColor: Colors.white),
    scaffoldBackgroundColor: Colors.white,
    dividerTheme: DividerThemeData(color: Colors.transparent),
  );
}

abstract class AppRoutes {
  static const String auth = '/auth';
  static const String splash = '/splash';
  static const String home = '/home';
  static const String agencyDetails = '/agencyDetails';
  static const String taskDetails = '/taskDetails';
  static const String editTask = '/editTask';
  static const String measurement = '/measurement';
  static const String newCustomer = '/newCustomer';
  static const String editAgency = '/editAgency';
  static const String reviewBill = '/reviewBill';
  static const String quoteDetails = '/quoteDetails';
  static const String editQuote = '/editQuote';
}

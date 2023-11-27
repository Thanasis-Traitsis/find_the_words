import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';
import '../../core/constants/sizes.dart';
import '../../core/constants/styles.dart';
import 'colors.dart';

class MainAppTheme {
  final MainColors colorTheme;
  final AppValuesMain values;

  MainAppTheme(
    this.colorTheme,
    this.values,
  );

  late ThemeData mainTheme = ThemeData(
    fontFamily: fontName,
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      background: colorTheme.bgColor,
      primary: colorTheme.primaryColor,
      outline: colorTheme.black,
      surface: colorTheme.white,
      secondary: colorTheme.highlightColor,
      primaryContainer: colorTheme.pinkHighlightColor,
    ),
    canvasColor: colorTheme.lightGreenColor,
    cardColor: colorTheme.babyBlueColor,
    appBarTheme: AppBarTheme(
      backgroundColor: colorTheme.bgColor,
      foregroundColor: colorTheme.black,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        fontSize: values.largeText,
      ),
      bodyMedium: TextStyle(
        fontSize: values.mediumText,
      ),
      bodySmall: TextStyle(
        fontSize: values.normalText,
      ),
      headlineLarge: TextStyle(
        fontSize: values.veryLargeText,
      ),
    ),
    primaryIconTheme: IconThemeData(
      size: values.normalIcon,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(colorTheme.highlightColor),
        foregroundColor: MaterialStateProperty.all<Color>(colorTheme.white),
        padding: MaterialStateProperty.all<EdgeInsets>(
          buttonSpacing,
        ),
        textStyle: MaterialStateProperty.all<TextStyle>(
          TextStyle(
            fontSize: values.largeText,
          ),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadiusButton),
            side: BorderSide(
              color: colorTheme.black,
              width: 2.0, // Adjust the width of the border as needed
            ),
          ),
        ),
      ),
    ),
  );
}

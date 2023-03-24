import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/utils/constants.utils.dart';

class ThemeUtils {
  const ThemeUtils._();
  static const appPadding = 20.0;
  static final themeData = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      textTheme: const TextTheme(
        headline1: TextStyle(
          color: Colors.black,
          fontSize: 36.0,
        ),
      ));
  static final themeDataDark = ThemeData(
      scaffoldBackgroundColor: Colors.black,
      textTheme: const TextTheme(
          headline1: TextStyle(
        color: Colors.white,
        fontSize: 36.0,
      )));
}

class ButtonStyles {
  static ButtonStyle elevatedButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(kPrimaryColor),
    foregroundColor: MaterialStateProperty.all(Colors.black),
  );
}

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static double? defaultSize;
  static Orientation? orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  // 812 is the layout height that designer use
  return (inputHeight / 812.0) * screenHeight;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  // 375 is the layout width that designer use
  return (inputWidth / 375.0) * screenWidth;
}

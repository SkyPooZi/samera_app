import '../colors/colors.dart';
import 'package:flutter/material.dart';
import '../typography/text_styles.dart';

class Themes {
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: const ColorScheme.light(
        primary: ColorsResources.colorsBlack,
        secondary: ColorsResources.colorsGrey,
        error: ColorsResources.colorsRed,
        outline: ColorsResources.colorsShimmer,
      ),
      shadowColor: ColorsResources.colorsShadowLight,
      cardColor: ColorsResources.colorsWhite,
      textTheme: _textTheme(ColorsResources.colorsBlack),
      brightness: Brightness.light,
      useMaterial3: true,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      colorScheme: const ColorScheme.dark(
        primary: ColorsResources.colorsWhite,
        secondary: ColorsResources.colorsGrey,
      ),
      shadowColor: ColorsResources.colorsShadowDark,
      cardColor: ColorsResources.colorsBlack,
      textTheme: _textTheme(ColorsResources.colorsWhite),
      brightness: Brightness.dark,
      useMaterial3: true,
    );
  }

  static TextTheme _textTheme(Color textColor) {
    return TextTheme(
      displayLarge: tsDisplayLargeMedium(textColor).copyWith(color: textColor),
      displayMedium:
          tsDisplayMediumMedium(textColor).copyWith(color: textColor),
      displaySmall: tsDisplaySmallMedium(textColor).copyWith(color: textColor),
      headlineLarge:
          tsHeadlineLargeMedium(textColor).copyWith(color: textColor),
      headlineMedium:
          tsHeadlineMediumMedium(textColor).copyWith(color: textColor),
      headlineSmall:
          tsHeadlineSmallMedium(textColor).copyWith(color: textColor),
      titleLarge: tsTitleLargeMedium(textColor).copyWith(color: textColor),
      titleMedium: tsTitleMediumMedium(textColor).copyWith(color: textColor),
      titleSmall: tsTitleSmallMedium(textColor).copyWith(color: textColor),
      bodyLarge: tsBodyLargeMedium(textColor).copyWith(color: textColor),
      bodyMedium: tsBodyMediumMedium(textColor).copyWith(color: textColor),
      bodySmall: tsBodySmallMedium(textColor).copyWith(color: textColor),
      labelLarge: tsLabelLargeMedium(textColor).copyWith(color: textColor),
      labelMedium: tsLabelMediumMedium(textColor).copyWith(color: textColor),
      labelSmall: tsLabelSmallMedium(textColor).copyWith(color: textColor),
    );
  }
}

import 'package:flutter/material.dart';

Color mainTextColor() => const Color(0xFF000000);

Color mainColor({double opacity = 1}) {
  if (opacity == 1) return const Color(0xFF0088CE);

  return Color(((opacity * 255).ceil() << 24) | 0x0002457A);
}

Color accentColor({double opacity = 1}) {
  if (opacity == 1) return const Color(0xFFEF4B4C);

  return Color(((opacity * 255).ceil() << 24) | 0x00EF4B4C);
}

Color lightGreyColor() => const Color(0xFFEFEFEF);

Color darkGreyColor() => const Color(0xFFA0A0A0);

ThemeData theme() => ThemeData(
      fontFamily: 'AvenirNext',
      primaryColor: mainColor(),
      textTheme: TextTheme(
        headline6: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.w600,
          color: mainTextColor().withOpacity(1),
        ),
        headline5: TextStyle(
          fontSize: 24.0,
          color: mainTextColor(),
          fontWeight: FontWeight.w600,
        ),
        headline4: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w400,
          color: mainTextColor(),
        ),
        bodyText1: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
        ),
        bodyText2: const TextStyle(fontSize: 16.0),
        subtitle2: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
        subtitle1: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          color: mainTextColor().withOpacity(0.4),
        ),
        caption: const TextStyle(fontSize: 14.0),
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: mainColor()),
    );

double shimmerTextHeight() => 16.0;

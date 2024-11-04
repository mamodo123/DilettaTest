import 'package:flutter/material.dart';

const appName = 'Rick and Morty Wishlist';

final themeData = ThemeData(
  primaryColor: Colors.greenAccent,
  hintColor: Colors.greenAccent.shade400,
  scaffoldBackgroundColor: Colors.greenAccent.shade100,
  appBarTheme: AppBarTheme(
    color: Colors.greenAccent.shade700,
    iconTheme: const IconThemeData(color: Colors.white),
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.green,
    accentColor: Colors.greenAccent.shade400,
  ).copyWith(
    secondary: Colors.greenAccent.shade200,
  ),
  iconTheme: IconThemeData(color: Colors.greenAccent.shade700),
  cardColor: Colors.greenAccent.shade100,
  dividerColor: Colors.greenAccent.shade400,
);
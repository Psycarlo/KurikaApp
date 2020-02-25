import 'package:flutter/material.dart';

enum AppTheme {
  Light,
  Night,
}

// TODO
final Map<AppTheme, ThemeData> appThemeData = {
  AppTheme.Light: ThemeData(
    primaryColor: Colors.white
  ),
  AppTheme.Night: ThemeData(
    primaryColor: Colors.black
  )
};
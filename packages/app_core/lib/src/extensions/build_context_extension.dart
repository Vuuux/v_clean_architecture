import 'package:flutter/material.dart';

extension ThemeColorExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  Size get screenSize => MediaQuery.of(this).size;
  double get dpr => MediaQuery.of(this).devicePixelRatio;
}

import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {
  // ThemeData get _theme => Theme.of(this);
  // TextTheme get textTheme => _theme.textTheme;
  // TextStyle? get textStyleSmall => textTheme.labelSmall;
  // TextStyle? get textStyleMedium => textTheme.labelMedium;
  // TextStyle? get textStyleLarge => textTheme.labelLarge;
  // TextStyle? get titleStyleSmall => textTheme.titleSmall;
  // TextStyle? get titleStyleMedium => textTheme.titleMedium;
  // TextStyle? get titleStyleLarge => textTheme.titleLarge;
  // ColorScheme get colorScheme => _theme.colorScheme;
  Size get sizeDevice => MediaQuery.sizeOf(this);
  bool get isMobile => sizeDevice.width < 500;
  bool get isTablet =>
      sizeDevice.shortestSide >= 500 && sizeDevice.width < 1100;
  bool get isDesktop => sizeDevice.shortestSide >= 1100;
  bool get is4k => sizeDevice.shortestSide >= 1920;
}

void pop(BuildContext context, int returnedLevel) {
  for (var i = 0; i < returnedLevel; ++i) {
    Navigator.pop(context, true);
  }
}

import 'package:flutter/material.dart';

class AppDefaultColor {
  AppDefaultColor._();

  static const _brownPrimaryValue = 0xFF4d1c21;
  static const _yellowPrimaryValue = 0xFFf6c35b;
  static const _bluePrimaryValue = 0xFF76d3ee;

  static const MaterialColor defaultBrown =
      MaterialColor(_brownPrimaryValue, <int, Color>{});
  static const MaterialColor defaultYellow =
      MaterialColor(_yellowPrimaryValue, <int, Color>{});
  static const MaterialColor defaultBlue =
      MaterialColor(_bluePrimaryValue, <int, Color>{});
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';

class AppCfg {
  static const hGap10 = SizedBox(height: 10,);
  static const wGap10 = SizedBox(width: 10,);

  static const largeWidth = 900;

  static const logLevel = Level.ALL;

  static String formatTwoDigit(int value) => NumberFormat('00').format(value);
}
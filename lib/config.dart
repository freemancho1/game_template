import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';

class AppCfg {
  static const baseEdgeSize = 8.0;
  static const hGap10 = SizedBox(height: 10,);
  static const wGap10 = SizedBox(width: 10,);
  static const gapSS = SizedBox(height: 60,);   /// SettingsScreen

  static const largeWidth = 900;

  static const debugLogLevel = Level.ALL;
  static const releaseLogLevel = Level.WARNING;

  static const bool initMuted = false;
  static const bool initMusicOn = false;
  static const bool initSoundsOn = false;
  static const String initPlayerName = 'Player';

  static const maxHighestScoresPerPlayer = 10;

  static String formatTwoDigit(int value) => NumberFormat('00').format(value);
}
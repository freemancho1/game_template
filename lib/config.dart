import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';

class AppCfg {
  static const TextStyle styleMainTitle = TextStyle(
    fontFamily: 'Permanent Marker',
    fontSize: 60,
    height: 1,
  );
  static const TextStyle styleSettingsItem = TextStyle(
    fontFamily: 'Permanent Marker',
    fontSize: 30,
  );
  static const styleSelectLevel = styleSettingsItem;

  static const baseEdgeSize = 8.0;
  static const hGap10 = SizedBox(height: 10,);
  static const wGap10 = SizedBox(width: 10,);
  static const paddingSLS = EdgeInsets.all(16);   /// SelectLevelScreen
  static const gapSLS = SizedBox(height: 50,);
  static const gapMB = EdgeInsets.only(top: 32);  /// MutedButton in MainMenu
  static const gapSS = SizedBox(height: 60,);     /// SettingsScreen

  static const largeWidth = 900;

  static const debugLogLevel = Level.ALL;
  static const releaseLogLevel = Level.WARNING;

  static const bool initMuted = false;
  static const bool initMusicOn = false;
  static const bool initSoundsOn = false;
  static const String initPlayerName = 'Player';

  static const maxHighestScoresPerPlayer = 10;

  static const pageTransitionDuration = Duration(milliseconds: 700);
  static const pageOpacityDuration = Duration(milliseconds: 300);
  static const durationCelebration = Duration(milliseconds: 2000);
  static const durationPreCelebration = Duration(milliseconds: 500);

  static String formatTwoDigit(int value) => NumberFormat('00').format(value);
}
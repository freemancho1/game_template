import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_template/config.dart';
import 'package:game_template/src/utils/crashlytics.dart';
import 'package:logging/logging.dart';

Logger _log = Logger('main.dart');

Future<void> main() async {
  FirebaseCrashlytics? crashlytics;
  await guardWithCrashlytics(guardedMain, crashlytics: crashlytics);
}

/// 로깅과 충돌 보고가 없으면 그냥 void main()임.
void guardedMain() {

  Logger.root.level = kReleaseMode ? Level.WARNING: AppCfg.logLevel;
  Logger.root.onRecord.listen((record) {
    debugPrint(
      '${record.level.name}: '
      '${record.time}: '
      '${record.loggerName}: '
      '${record.message}'
    );
  });

  WidgetsFlutterBinding.ensureInitialized();

  _log.info('Going full screen');
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,);

  // Todo: 준비가되면 아래 각 컨트롤러를 완성해야 함.(광고, 게임서비스, 인앱결제)

  /// AdsController? adsController;
  /// GamesServicesController? gamesServicesController;
  /// InAppPurchaseController? inAppPurchaseController;

  // Todo: runApp
}
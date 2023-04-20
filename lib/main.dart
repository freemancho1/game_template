import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_template/src/app_lifecycle/app_lifecycle.dart';
import 'package:game_template/src/main_menu/main_menu_screen.dart';
import 'package:game_template/style/palette.dart';
import 'package:game_template/style/snack_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:game_template/config.dart';
import 'package:game_template/src/crashlytics/crashlytics.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

Logger _log = Logger('main.dart');

Future<void> main() async {
  FirebaseCrashlytics? crashlytics;
  await guardWithCrashlytics(guardedMain, crashlytics: crashlytics);
}

/// 로깅과 충돌 보고가 없으면 그냥 void main()임.
void guardedMain() {

  Logger.root.level = kReleaseMode ? Level.WARNING: AppCfg.debugLogLevel;
  Logger.root.onRecord.listen((record) {
    debugPrint(
      '${record.level.name}: '
      '${record.time}: '
      '${record.loggerName}: '
      '${record.message}'
    );
  });

  WidgetsFlutterBinding.ensureInitialized();

  _log.info('++ 전체화면 모드');
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,);

  // Todo: 준비가되면 아래 각 컨트롤러를 완성해야 함.(광고, 게임서비스, 인앱결제)

  /// AdsController? adsController;
  /// GameServicesController? gameServicesController;
  /// InAppPurchaseController? inAppPurchaseController;

  // Todo: runApp
  runApp(const GameMain());
}

class GameMain extends StatelessWidget {
  // Todo: 계속 추가해 갈 것.
  const GameMain({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLifecycleObserver(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) {

            }
          ),
        ],
        child: Builder(
          builder: (context) {
            final palette = context.watch<Palette>();
            return MaterialApp.router(
              title: 'Flutter Game Demo',
              routeInformationProvider: _router.routeInformationProvider,
              routeInformationParser: _router.routeInformationParser,
              routerDelegate: _router.routerDelegate,
              scaffoldMessengerKey: scaffoldMessengerKey,
            );
          }
        )
      )
    );
  }

  static final _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) =>
          const MainMenuScreen(key: Key('main menu')),
        routes: [],
      )
    ]
  );
}
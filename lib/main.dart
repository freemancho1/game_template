import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_template/src/app_lifecycle/app_lifecycle.dart';
import 'package:game_template/src/main_menu/main_menu_screen.dart';
import 'package:game_template/src/player_progress/persistence/player_progress_persistence.dart';
import 'package:game_template/src/player_progress/persistence/player_progress_persistence_ls.dart';
import 'package:game_template/src/player_progress/player_progress.dart';
import 'package:game_template/src/settings/persistence/settings_persistence.dart';
import 'package:game_template/src/settings/persistence/settings_persistence_ls.dart';
import 'package:game_template/src/settings/settings_controller.dart';
import 'package:game_template/src/settings/settings_screen.dart';
import 'package:game_template/src/style/palette.dart';
import 'package:game_template/src/style/snack_bar.dart';
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

  Logger.root.level =
    kReleaseMode ? AppCfg.releaseLogLevel: AppCfg.debugLogLevel;
  Logger.root.onRecord.listen((record) {
    // todo: 이 부분 때문에 로그가 중복 출력되는데, 제거해도 되는지 확인 필요.
    debugPrint(
      '${record.level.name}: '
      '${record.time}: '
      '${record.loggerName}: '
      '${record.message}'
    );
  });
  _log.info('++ 로그 레벨: ${Logger.root.level.toString()}');

  /// 플루터 관련 모든 초기화 작업을 보장함.
  /// 따라서, 플루터로 앱을 개발할 때 반드시 [runApp()] 앞에 선언해 줘야함.
  WidgetsFlutterBinding.ensureInitialized();

  _log.info('++ 전체화면 모드');
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,);

  // Todo: 준비가되면 아래 각 컨트롤러를 완성해야 함.(광고, 게임서비스, 인앱결제)

  /// AdsController? adsController;
  /// GameServicesController? gameServicesController;
  /// InAppPurchaseController? inAppPurchaseController;

  // Todo: runApp
  runApp(GameMain(
    playerProgressPersistence: LocalStoragePlayerProgressPersistence(),
    settingsPersistence: LocalStorageSettingsPersistence(),
  ));
}

class GameMain extends StatelessWidget {
  final PlayerProgressPersistence playerProgressPersistence;
  final SettingsPersistence settingsPersistence;
  // Todo: 계속 추가해 갈 것.
  const GameMain({
    super.key,
    required this.playerProgressPersistence,
    required this.settingsPersistence,
  });

  @override
  Widget build(BuildContext context) {
    return AppLifecycleObserver(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) {
              PlayerProgress progress =
                PlayerProgress(playerProgressPersistence);
              // todo: Future<void>인데 그냥 부르네?
              progress.getLatestFromStore();
              return progress;
            }
          ),
          Provider<SettingsController>(
            lazy: false,
            create: (context) => SettingsController(
              persistence: settingsPersistence
            )..loadStateFromPersistence(),    /// 초기화
          ),
          /// [Palette] 상태정보 제공,
          /// 이게 있어야 아래 Builder에서 context.watch를 할 수 있음.
          Provider(create: (context) => Palette()),
        ],
        child: Builder(
          builder: (context) {
            final palette = context.watch<Palette>();
            return MaterialApp.router(
              title: 'Flutter Game Demo',
              theme: ThemeData.from(
                colorScheme: ColorScheme.fromSeed(
                  seedColor: palette.darkPen,
                  background: palette.backgroundMain
                ),
                textTheme: TextTheme(
                  bodyMedium: TextStyle(color: palette.ink),
                ),
                useMaterial3: true,
              ),
              routeInformationProvider: _router.routeInformationProvider,
              routeInformationParser: _router.routeInformationParser,
              routerDelegate: _router.routerDelegate,
              /// scaffoldMessengerKey는 [lib/src/style/snack_bar.dart]에 구현됨
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
        routes: [
          GoRoute(
            path: 'settings',
            builder: (context, state) =>
                const SettingsScreen(key: Key('settings'),),
          )
        ],
      )
    ]
  );
}
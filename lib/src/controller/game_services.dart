import 'package:game_template/src/utils/score.dart';
import 'package:logging/logging.dart';
import 'package:games_services/games_services.dart' as gs;
import 'dart:async';

/// 게임 서비스의 UI 오버레이(기존 위젯 위에 새로운 위젯을 표시, 예: 업적 달성 알림 등)를
/// 표시하고, 이를 통해 업적 및 리더보드 점수를 표시하는데 사용하는 컨트롤러.

class GameServicesController {
  static final Logger _log = Logger('GamesServicesController');
  /// 비동기 작업인 로그인 작업이 완료될때까지 기다리는데 사용하는 completer로,
  /// 자체적으로 Future 객체를 생성하고 이 객체가 완료될 때 까지 기다림
  final Completer<bool> _signedInCompleter = Completer();
  Future<bool> get signedIn => _signedInCompleter.future;

  /// 점수등록 = 업적 달성 = (뭔가) 해제?

  /// 게임센터나 플레이게임즈에서 점수를 등록할 때 사용하며, 'iOS'와 'android'에서
  /// 매개변수를 통해 업적ID를 제공해야 함.
  /// (해당 게임서비스에 로그인되어있지 않으면 아무것도 않 함)
  Future<void> awardAchievement({
    required String iOS, required String android}) async {
    if (!await signedIn) {
      _log.warning('로그인하지 않은 상태에서 점수를 등록하려 했습니다.');
      return;
    }

    try {
      /// 개입 업적 달성(뭔가를 해제하는 것이 게임에서는 업적 달성)
      await gs.GamesServices.unlock(
        achievement: gs.Achievement(androidID: android, iOSID: iOS),
      );
    } catch(e) {
      _log.severe('점수를 등록하지 못했습니다:\n${e.toString()}');
    }
  }

  /// 게임서비스(게임센터나 플레이 게임즈?)에 로그인
  Future<void> initialize() async {
    try {
      await gs.GamesServices.signIn();
      final signedIn = await gs.GamesServices.isSignedIn;
      _signedInCompleter.complete(signedIn);
    } catch(e) {
      _log.severe('게임서비스에 로그인할 수 없습니다.\nError: ${e.toString()}');
      _signedInCompleter.complete(false);
    }
  }

  /// '달성도'를 나타내는 시스템의 UI 오버레이를 실행함.
  Future<void> showAchievements() async {
    if (!await signedIn) {
      _log.severe('로그인하지 않은 상태에서 달성도를 볼 수 없습니다.');
      return;
    }

    try {
      await gs.GamesServices.showAchievements();
    } catch (e) {
      _log.severe('달성도를 볼 수 없습니다.\nError:${e.toString()}');
    }
  }

  /// 사용자 점수판(리더보드)을 UI 오버레이로 실행함
  Future<void> showLeaderBoard() async {
    if (!await signedIn) {
      _log.severe('로그인을 하지 않은 상태에서 달성도를 볼 수 없습니다.');
      return;
    }

    try {
      await gs.GamesServices.showLeaderboards(
        // Todo: 실제 iOS와 Android 리더보드 ID를 가져와 적용해야 함.
        iOSLeaderboardID: 'some_id_from_app_store',
        androidLeaderboardID: 'smoe_id_from_google_play',
      );
    } catch(e) {
      _log.severe('리더보드를 볼 수 없습니다.\nError:${e.toString()}');
    }
  }

  /// 리더보드에 점수를 제공합니다.
  Future<void> submitLeaderboardScore(Score score) async {
    if (!await signedIn) {
      _log.severe('로그인을 하지 않은 상태에서 점수를 등록할 수 없습니다.');
      return;
    }

    try {
      await gs.GamesServices.submitScore(
        score: gs.Score(
          // Todo: 실제 iOS와 Android 리더보드 ID를 가져와 적용해야 함.
          iOSLeaderboardID: 'some_id_from_app_store',
          androidLeaderboardID: 'smoe_id_from_google_play',
          value: score.score,
        ),
      );
      _log.info('점수($score)를 리더보드에 제출하였습니다.');
    } catch(e) {
      _log.severe('점수($score)를 리더보드에 제출하지 못했습니다.\nError:$e');
    }
  }

}
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:game_template/src/player_progress/persistence/player_progress_persistence.dart';
import 'package:logging/logging.dart';

final Logger _log = Logger('player_progress.dart');

/// 플레이어의 상태를 캡슐화 함
class PlayerProgress extends ChangeNotifier {
  final PlayerProgressPersistence _store;
  PlayerProgress(PlayerProgressPersistence store) : _store = store;

  int _highestLevelReached = 0;
  int get highestLevelReached => _highestLevelReached;

  // todo: _store 구현체에서 이미 awiat를 수행하기 때문에 여기서는 await를 사용하지
  //       않아도 되는거 아닌가? 확인필
  Future<void> getLatestFromStore() async {
    final level = await _store.getHighestLevelReached();
    _log.info('++ 현재 최고레벨: $_highestLevelReached, 저장된 최고레벨: $level');

    if (level > _highestLevelReached) {
      _highestLevelReached = level;
      notifyListeners();
    } else if (level < _highestLevelReached) {
      await _store.saveHighestLevelReached(_highestLevelReached);
    }
  }

  /// 게임 초기화
  // todo: Future<void>가 아닌 void로 되어 있는데, 문제없나 확인 필요.(호출방법 등)
  void reset() {
    _highestLevelReached = 0;
    notifyListeners();
    _store.saveHighestLevelReached(_highestLevelReached);
  }

  // todo: Future<void>가 아닌 void로 되어 있는데, 문제없나 확인 필요.(호출방법 등)
  void setLevelReached(int level) {
    if (level > _highestLevelReached) {
      _highestLevelReached = level;
      notifyListeners();
      /// unawaited: 비동기 처리에서 반환값을 받을 필요가 없으니 기다리지 않고 바로 진행
      /// 하지만, 저장 과정에서 오류가 발생할 수 있으므로 신중하게 처리할 필요가 있음.
      unawaited(_store.saveHighestLevelReached(level));
    }
  }

}
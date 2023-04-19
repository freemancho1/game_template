import 'dart:collection';
import 'dart:math';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:game_template/src/audio/songs.dart';
import 'package:game_template/src/settings/settings.dart';
import 'package:logging/logging.dart';

class AudioController {
  static final _log = Logger('AutioController');

  final AudioPlayer _musicPlayer;
  /// 소리효과 재생 목록
  final List<AudioPlayer> _sfxPlayers;
  final Queue<Song> _playList;
  final Random _random = Random();
  /// 동시에 재생할 수 있는 음향 신호의 수: 여기선 기본값 2
  AudioController({int polyphony = 2})
    /// polyphony가 1 이하이면, AssertionError를 발생시킴
    /// 디버깅 목적으로 사용되며, polyphony값이 항상 1보다 크도록 보장함.
    /// ':'을 이용해 생성자에서 기본적인 코드를 구현해 값을 초기화 할 수 있음.
    : assert(polyphony >= 1),
      _musicPlayer = AudioPlayer(playerId: 'musicPlayer'),
      _sfxPlayers = Iterable.generate(
        polyphony, (index) => AudioPlayer(playerId: 'sfxPlayer#$index')
      ).toList(growable: false),
      _playList = Queue.of(List<Song>.of(songs)..shuffle()) {
        /// 음악이 종료되면 새로운 음악으로 바꾸도록 _changeSong을 호출함.
        _musicPlayer.onPlayerComplete.listen(_changeSong);
      }

  int _currentSfxPlayer = 0;
  SettingsController? _settings;
  ValueNotifier<AppLifecycleState>? _lifecycleNotifier;

  // Todo: 여기서부터 구현........

  void _changeSong(void _) {
    _log.info('마지막 음악이 종료되었습니다.');
    _playList.addLast(_playList.removeFirst());
    // Todo: 추가
    // _playFirstSongInPlaylist();
  }

}
import 'package:flutter/foundation.dart';
import 'package:game_template/src/settings/persistence/settings_persistence.dart';

class SettingsController {
  final SettingsPersistence _persistence;
  SettingsController({required SettingsPersistence persistence})
    : _persistence = persistence;

  /// 사운드가 켜져 있는지 여부로, 음악과 사운드에서 공유함.
  ValueNotifier<bool> muted = ValueNotifier(false);
  ValueNotifier<String> playerName = ValueNotifier('Player');
  ValueNotifier<bool> soundsOn = ValueNotifier(false);
  ValueNotifier<bool> musicOn = ValueNotifier(false);

  /// 지정된 영구 저장소에서 값들을 비동기적으로 불러옴.
  Future<void> loadStateFromPersistence() async {
    await Future.wait([
      /// 지정된 영구 저장소에서 음소거값(getMuted)를 기본값(kIsWeb)으로 가져오고,
      /// 가져온 값을 이용해 위 'muted'변수의 'value'값을 업데이트 함.
      _persistence.getMuted(defaultValue: kIsWeb).then((v) => muted.value = v),
      _persistence.getSoundsOn().then((value) => soundsOn.value = value),
      _persistence.getMusicOn().then((value) => musicOn.value = value),
      _persistence.getPlayereName().then((value) => playerName.value = value),
    ]);
  }

  void setPlayerName(String value) {
    playerName.value = value;
    _persistence.setPlayerName(value);
  }

  void toggleMusicOn() {
    musicOn.value = !musicOn.value;
    _persistence.setMusicOn(musicOn.value);
  }

  void toggleSoundsOn() {
    soundsOn.value = !soundsOn.value;
    _persistence.setSoundsOn(soundsOn.value);
  }

  void toggleMuted() {
    muted.value = !muted.value;
    _persistence.setMuted(muted.value);
  }
}
import 'package:flutter/foundation.dart';
import 'package:game_template/config.dart';
import 'package:game_template/src/settings/persistence/settings_persistence.dart';

class SettingsController {
  final SettingsPersistence _persistence;
  SettingsController({required SettingsPersistence persistence})
    : _persistence = persistence;

  ValueNotifier<bool> muted = ValueNotifier(AppCfg.initMuted);
  ValueNotifier<bool> musicOn = ValueNotifier(AppCfg.initMusicOn);
  ValueNotifier<bool> soundsOn = ValueNotifier(AppCfg.initSoundsOn);
  ValueNotifier<String> playerName = ValueNotifier(AppCfg.initPlayerName);

  Future<void> loadStateFromPersistence() async {
    await Future.wait([
      _persistence.getMuted(defaultValue: kIsWeb).then((v) => muted.value = v),
      _persistence.getMusicOn().then((value) => musicOn.value = value),
      _persistence.getSoundsOn().then((value) => soundsOn.value = value),
      _persistence.getPlayerName().then((value) => playerName.value = value),
    ]);
  }

  void toggleMuted() {
    muted.value = !muted.value;
    _persistence.saveMuted(muted.value);
  }

  void toggleMusicOn() {
    musicOn.value = !musicOn.value;
    _persistence.saveMusicOn(musicOn.value);
  }

  void toggleSoundsOn() {
    soundsOn.value = !soundsOn.value;
    _persistence.saveSoundsOn(soundsOn.value);
  }

  void setPlayerName(String value) {
    playerName.value = value;
    _persistence.savePlayerName(value);
  }

}
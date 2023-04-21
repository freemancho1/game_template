import 'package:game_template/config.dart';
import 'package:game_template/src/settings/persistence/settings_persistence.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageSettingsPersistence extends SettingsPersistence {
  final Future<SharedPreferences> instance = SharedPreferences.getInstance();

  @override
  Future<bool> getMusicOn() async =>
      (await instance).getBool('musicOn') ?? AppCfg.initMusicOn;

  @override
  Future<bool> getMuted({required bool defaultValue}) async =>
      (await instance).getBool('mute') ?? defaultValue;

  @override
  Future<String> getPlayerName() async =>
      (await instance).getString('playerName') ?? AppCfg.initPlayerName;

  @override
  Future<bool> getSoundsOn() async =>
      (await instance).getBool('soundsOn') ?? AppCfg.initSoundsOn;

  @override
  Future<void> saveMusicOn(bool value) async =>
      (await instance).setBool('musicOn', value);

  @override
  Future<void> saveMuted(bool value) async =>
      (await instance).setBool('mute', value);

  @override
  Future<void> savePlayerName(String value) async =>
      (await instance).setString('playerName', value);

  @override
  Future<void> saveSoundsOn(bool value) async =>
      (await instance).setBool('soundsOn', value);

}
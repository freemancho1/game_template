abstract class SettingsPersistence {

  Future<bool> getMusicOn();
  Future<void> saveMusicOn(bool value);

  Future<bool> getMuted({required bool defaultValue});
  Future<void> saveMuted(bool value);

  Future<String> getPlayerName();
  Future<void> savePlayerName(String value);

  Future<bool> getSoundsOn();
  Future<void> saveSoundsOn(bool value);
}
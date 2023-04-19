/// 설정값 저장을 위한 인터페이스
/// 설정값은 로컬 저장소나 서버에 저장할 수 있기 때문에 인터페이스를 생성하면 편리함.
abstract class SettingsPersistence {
  Future<bool> getMusicOn();
  Future<void> setMusicOn(bool value);

  /// 음소거(muted) 여부 확인
  Future<bool> getMuted({required bool defaultValue});
  Future<void> setMuted(bool value);

  Future<String> getPlayereName();
  Future<void> setPlayerName(String value);

  Future<bool> getSoundsOn();
  Future<void> setSoundsOn(bool value);
}
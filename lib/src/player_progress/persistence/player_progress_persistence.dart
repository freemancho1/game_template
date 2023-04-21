abstract class PlayerProgressPersistence {
  /// 도달한 최대 레벨을 관리함.
  Future<int> getHighestLevelReached();
  Future<void> saveHighestLevelReached(int level);
}
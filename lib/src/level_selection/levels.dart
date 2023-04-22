class GameLevel {
  final int number;
  final int difficulty;
  /// 아래 두개는 둘다 있거나, 둘다 없어야 함
  final String? achievementIdIOS;
  final String? achievementIdAndroid;
  const GameLevel({
    required this.number,
    required this.difficulty,
    this.achievementIdIOS,
    this.achievementIdAndroid,
  }) : assert(
    /// 둘다 있거나, 없거나
    (achievementIdIOS != null && achievementIdAndroid != null) ||
    (achievementIdIOS == null && achievementIdAndroid == null)
  );

  bool get awardsAchievement => achievementIdAndroid != null;
}

const gameLevels = [
  GameLevel(
    number: 1,
    difficulty: 5,
    achievementIdIOS: 'first_win',
    achievementIdAndroid: 'adafASDFafafdsa',    /// 임의문자
  ),
  GameLevel(
    number: 2,
    difficulty: 46,
  ),
  GameLevel(
    number: 3,
    difficulty: 100,
    achievementIdIOS: 'finished',
    achievementIdAndroid: 'fdklasfaDFadsfasf',    /// 임의문자
  ),
];
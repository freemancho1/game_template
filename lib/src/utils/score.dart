import 'package:flutter/material.dart';
import 'package:game_template/config.dart';

/// 점수와 해당 점수를 계산하는 방법을 캡슐화 함.
/// 이 클래스는 @immutable로 지정해 한번 생성되면 변경 할 수 없다.(즉 모든 내부 변수가 final임)
@immutable
class Score {
  final int score;
  final Duration duration;
  final int level;

  /// 생성자를 private로 설정함. (일반적으로 데이터 클래스를 생성할 때 많이 사용할 거 같음)
  /// const 생성자는 생성자 안에서 별도의 기능을 구현할 수 없기 때문에,
  /// factory 생성자를 이용해 특정 기능을 구현하기 위해 private 생성자를 만듬.
  const Score._(this.score, this.duration, this.level);

  factory Score(int level, int difficulty, Duration duration) {
    int score = difficulty;
    score *= 10000 ~/ (duration.inSeconds.abs() + 1);
    return Score._(score, duration, level);
  }

  String get formattedTime {
    final StringBuffer buffer = StringBuffer();

    if (duration.inHours > 0) buffer.write('${duration.inHours}:');
    final minutes = duration.inMinutes % Duration.minutesPerHour;
    buffer.write('${AppCfg.formatTwoDigit(minutes)}:');   /// B와 동일
    final seconds = duration.inSeconds % Duration.secondsPerMinute;
    buffer.write(seconds.toString().padLeft(2, '0'));     /// B

    return buffer.toString();
  }

  @override
  String toString() =>
    'Score<score:$score, duration:$formattedTime, level:$level>';
}
import 'package:flutter/material.dart';
import 'package:game_template/src/utils/score.dart';

void main() {
  final Score score = Score(2, 500, const Duration(milliseconds: 5555555));
  debugPrint(score.toString());
}
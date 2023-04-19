import 'package:flutter/material.dart';

/// 게임에서 사용할 색상 팔레트
///
/// 일반적으로 게임에서 Material Design의 'Theme'를 사용하지 않는다.
/// 이유는,
///   1. (거의 모든) 게임은 어두운 테마를 사용하지 않는다.
///   2. 이렇게 하는 것이 더 단순하고 유연하다.
///
/// 일반적으로 색상들은 'static const'를 이용해 사용하지만, 'getter'를 사용함으로써
///   1. hot reloading을 허용하며,
///   2. 색상을 사용자 정의(네트웍을 통해 가져올 수 있음)할 수 있음.

class Palette {
  Color get pen => const Color(0xff1d75fb);
  Color get darkPen => const Color(0xFF0050bc);
  Color get redPen => const Color(0xFFd10841);
  Color get inkFullOpacity => const Color(0xff352b42);
  Color get ink => const Color(0xee352b42);
  Color get backgroundMain => const Color(0xffffffd1);
  Color get backgroundLevelSelection => const Color(0xffa2dcc7);
  Color get backgroundPlaySession => const Color(0xffffebb5);
  Color get background4 => const Color(0xffffd7ff);
  Color get backgroundSettings => const Color(0xffbfc8e3);
  Color get trueWhite => const Color(0xffffffff);
}
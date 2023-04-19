import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  final StringBuffer buffer = StringBuffer();
  const int a = 7, b = 110;
  NumberFormat formattedTwoDigit = NumberFormat('00');
  String ftd(int value) => NumberFormat('00').format(value);
  buffer.write(formattedTwoDigit.format(a));
  buffer.write(':');
  buffer.write(formattedTwoDigit.format(b));
  debugPrint('(${buffer.length})$buffer');
}
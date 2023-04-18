import 'package:flutter/material.dart';

void main() {
  final array = ['apple', 'banana', 'orange'];
  const str1 = 'I like apple pie.';
  const str2 = 'I ate a watermelon.';

  debugPrint('${array.any((e) => str1.contains(e))}');
  debugPrint('${array.any((e) => str2.contains(e))}');
}
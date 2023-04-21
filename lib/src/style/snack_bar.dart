import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
  GlobalKey(debugLabel: 'scaffoldMessengerKey');

void showSnackBar(String message) {
  final messenger = scaffoldMessengerKey.currentState;
  messenger?.showSnackBar(SnackBar(content: Text(message)));
}
import 'package:flutter/material.dart';
import 'package:game_template/style/snack_bar.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('key::: $key');
    return Scaffold(
        body: Center(child: GestureDetector(
          onTap: () => showSnackBar('My SnackBar'),
          child: const Text("Main Menu Screen!"),
        ))
    );
  }
}

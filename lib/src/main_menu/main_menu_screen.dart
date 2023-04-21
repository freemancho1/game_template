import 'package:flutter/material.dart';
import 'package:game_template/config.dart';
import 'package:game_template/src/style/palette.dart';
import 'package:game_template/src/style/responsive_screen_layout.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Palette palette = context.watch<Palette>();

    return Scaffold(
      backgroundColor: palette.backgroundMain,
      body: ResponsiveScreenLayout(
        mainAreaProminence: 0.45,
        squarishMainArea: Center(
          child: Transform.rotate(
            angle: -0.2,
            child: const Text(
              'Flutter Game Template',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Permanent Marker',
                fontSize: 55,
                height: 1
              ),
            ),
          ),
        ),
        rectangularMenuArea: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FilledButton(
              onPressed: () {
                // todo: ...
                context.go('/play');
              },
              child: const Text('Play'),
            ),
            AppCfg.hGap10,
            // todo: ...
            FilledButton(
              onPressed: () => context.go('/settings'),
              child: const Text('Settings'),
            ),
            AppCfg.hGap10,
            // todo: ...
            const Text('Music by Mr Smith'),
            AppCfg.hGap10,
          ],
        ),
      ),
    );
  }
}

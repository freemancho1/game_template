import 'package:flutter/material.dart';
import 'package:game_template/config.dart';
import 'package:game_template/src/games_services/score.dart';
import 'package:game_template/src/style/palette.dart';
import 'package:game_template/src/style/responsive_screen_layout.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class WinGameScreen extends StatelessWidget {
  final Score score;
  const WinGameScreen({
    super.key,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    // todo: 인앱결재 처리 후
    // todo: 광고 처리 후
    final palette = context.watch<Palette>();

    return Scaffold(
      backgroundColor: palette.backgroundPlaySession,
      body: ResponsiveScreenLayout(
        squarishMainArea: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppCfg.hGap10,
            const Center(
              child: Text(
                'You Win!!',
                style: AppCfg.styleMainTitle,
              ),
            ),
            AppCfg.hGap10,
            Center(
              child: Text(
                'Score: ${score.score}\nTime: ${score.formattedTime}',
                style: AppCfg.styleSettingsItem,
              ),
            )
          ],
        ),
        rectangularMenuArea: FilledButton(
          onPressed: () => context.go('/play'),
          child: const Text('Continue'),
        ),
      ),
    );
  }
}

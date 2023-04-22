import 'package:flutter/material.dart';
import 'package:game_template/config.dart';
import 'package:game_template/src/level_selection/levels.dart';
import 'package:game_template/src/player_progress/player_progress.dart';
import 'package:game_template/src/style/palette.dart';
import 'package:game_template/src/style/responsive_screen_layout.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LevelSelectionScreen extends StatelessWidget {
  const LevelSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    final playerProgress = context.watch<PlayerProgress>();

    return Scaffold(
      backgroundColor: palette.backgroundLevelSelection,
      body: ResponsiveScreenLayout(
        squarishMainArea: Column(
          children: [
            const Padding(
              padding: AppCfg.paddingSLS,
              child: Center(
                child: Text(
                  'Select Level',
                  style: AppCfg.styleMainTitle,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            AppCfg.gapSLS,
            Expanded(
              child: ListView(
                children: [
                  for (final level in gameLevels)
                    ListTile(
                      enabled: playerProgress.highestLevelReached >=
                        level.number - 1,
                      onTap: () {
                        // todo: AudioController 추가 후 구현
                        context.go('/play/session/${level.number}');
                      },
                      leading: Text(
                        level.number.toString(),
                        style: AppCfg.styleSettingsItem,
                      ),
                      title: Text(
                        'Level #${level.number}',
                        style: AppCfg.styleSettingsItem,
                      ),
                    )
                ],
              )
            ),
          ],
        ),
        rectangularMenuArea: FilledButton(
          onPressed: () => context.go('/'),
          child: const Text('Back'),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:game_template/config.dart';
import 'package:game_template/src/settings/settings_controller.dart';
import 'package:game_template/src/style/palette.dart';
import 'package:game_template/src/style/responsive_screen_layout.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    final settingsController = context.watch<SettingsController>();

    return Scaffold(
      backgroundColor: palette.backgroundMain,
      /// 반응형 레이아웃 설정
      body: ResponsiveScreenLayout(
        mainAreaProminence: 0.45,
        squarishMainArea: Center(
          child: Transform.rotate(
            angle: -0.2,
            child: const Text(
              'Flutter Game Template',
              textAlign: TextAlign.center,
              style: AppCfg.styleMainTitle,
            ),
          ),
        ),
        rectangularMenuArea: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FilledButton(
              onPressed: () {
                // todo: router '/play' 구현 후 구현
                context.go('/play');
              },
              child: const Text('Play'),
            ),
            AppCfg.hGap10,
            // todo: 인앱결재 추가 시 구현
            FilledButton(
              onPressed: () => context.go('/settings'),
              child: const Text('Settings'),
            ),
            AppCfg.hGap10,
            Padding(
              padding: AppCfg.gapMB,
              child: ValueListenableBuilder<bool>(
                valueListenable: settingsController.muted,
                builder: (context, muted, child) {
                  return IconButton(
                    onPressed: () => settingsController.toggleMuted(),
                    icon: Icon(muted ? Icons.volume_off : Icons.volume_up),
                  );
                },
              ),
            ),
            AppCfg.hGap10,
            const Text('Music by Mr Smith'),
            AppCfg.hGap10,
          ],
        ),
      ),
    );
  }
}

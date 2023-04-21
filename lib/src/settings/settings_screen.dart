import 'package:flutter/material.dart';
import 'package:game_template/config.dart';
import 'package:game_template/src/player_progress/player_progress.dart';
import 'package:game_template/src/settings/custom_name_dialog.dart';
import 'package:game_template/src/settings/settings_controller.dart';
import 'package:game_template/src/style/palette.dart';
import 'package:game_template/src/style/responsive_screen_layout.dart';
import 'package:game_template/src/style/snack_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsController>();
    final palette = context.watch<Palette>();

    return Scaffold(
      backgroundColor: palette.backgroundSettings,
      body: ResponsiveScreenLayout(
        squarishMainArea: ListView(
          children: [
            AppCfg.hGap10,
            const Text(
              'Settings',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Permanent Marker',
                fontSize: 55,
                height: 1,
              ),
            ),
            AppCfg.hGap10,
            const _NameChangeLine('Name'),
            ValueListenableBuilder<bool>(
              valueListenable: settings.soundsOn,
              builder: (context, soundsOn, child) => _SettingsLine(
                'Sound Fx',
                Icon(soundsOn ? Icons.graphic_eq : Icons.volume_off),
                onSelected: () => settings.toggleSoundsOn(),
              )
            ),
            // todo: 인앱결재 구현시 추가
            _SettingsLine(
              'Reset progress',
              const Icon(Icons.delete),
              onSelected: () {
                context.read<PlayerProgress>().reset();
                /// 어디서나 스낵바를 호출해 사용할 수 있음.
                showSnackBar('플래이어의 정보가 초기화되었습니다.');
              },
            ),
          ],
        ),
        rectangularMenuArea: FilledButton(
          onPressed: () => context.pop(),
          child: const Text('Back'),
        ),
      ),
    );
  }
}

class _NameChangeLine extends StatelessWidget {
  final String title;
  const _NameChangeLine(this.title);

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsController>();
    return InkResponse(
      highlightShape: BoxShape.rectangle,
      onTap: () => showGeneralDialog(
        context: context,
        pageBuilder: (context, animation, secondaryAnimation) =>
          CustomNameDialog(animation: animation),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppCfg.baseEdgeSize),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Permanent Marker',
                fontSize: 30,
              ),
            ),
            const Spacer(),
            ValueListenableBuilder(
              valueListenable: settings.playerName,
              builder: (context, name, child) => Text(
                "'$name'",
                style: const TextStyle(
                  fontFamily: 'Permanent Marker',
                  fontSize: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsLine extends StatelessWidget {
  final String title;
  final Widget icon;
  final VoidCallback? onSelected;
  // todo: {this.onSelected}를 어떻게 호출하는지 확인.
  const _SettingsLine(this.title, this.icon, {this.onSelected});

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      highlightShape: BoxShape.rectangle,
      onTap: onSelected,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppCfg.baseEdgeSize),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: 'Permanent Marker',
                  fontSize: 30,
                ),
              )
            ),
            icon
          ],
        ),
      ),
    );
  }
}

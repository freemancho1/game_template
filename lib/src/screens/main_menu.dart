import 'package:flutter/material.dart';
import 'package:game_template/src/controller/game_services.dart';
import 'package:game_template/src/settings/settings.dart';
import 'package:provider/provider.dart';

import '../style/palette.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// StatelessWidget 클래스이지만,
    /// 'context.watch'를 이용해 해당 'palette'값이 변경되면,
    /// 'build'를 다시 호출해 UI를 재구성 함.
    final palette = context.watch<Palette>();
    final gameServicesController = context.watch<GameServicesController?>();
    final settingsController = context.watch<SettingsController>();
    // Todo: AudioController 구현 후 (가장 빨리 수행)

    return const Placeholder();
  }
}

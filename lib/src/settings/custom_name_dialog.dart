import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_template/config.dart';
import 'package:game_template/src/settings/settings_controller.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CustomNameDialog extends StatefulWidget {
  final Animation<double> animation;
  const CustomNameDialog({
    super.key,
    required this.animation,
  });

  @override
  State<CustomNameDialog> createState() => _CustomNameDialogState();
}

class _CustomNameDialogState extends State<CustomNameDialog> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final settings = context.read<SettingsController>();
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: widget.animation,
        curve: Curves.easeOutCubic,
      ),
      child: SimpleDialog(
        title: const Text('Change Name'),
        children: [
          TextField(
            controller: controller,
            autofocus: true,
            maxLength: 20,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            textAlign: TextAlign.center,
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.done,
            onChanged: (value) => settings.setPlayerName(value),
            onSubmitted: (value) {
              settings.setPlayerName(value);
              context.pop();
            },
          ),
          AppCfg.hGap10,
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Close'),
          )
        ],
      ),
    );
  }

  // todo: 이 함수 재정의 하지 않아도 되지 않나?
  @override
  void didChangeDependencies() {
    controller.text = context.read<SettingsController>().playerName.value;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

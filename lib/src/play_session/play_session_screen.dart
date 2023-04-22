import 'package:flutter/material.dart';
import 'package:game_template/config.dart';
import 'package:game_template/src/games_services/score.dart';
import 'package:game_template/src/level_selection/levels.dart';
import 'package:game_template/src/player_progress/player_progress.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

class PlaySessionScreen extends StatefulWidget {
  final GameLevel level;
  const PlaySessionScreen(this.level, {Key? key}) : super(key: key);

  @override
  State<PlaySessionScreen> createState() => _PlaySessionScreenState();
}

class _PlaySessionScreenState extends State<PlaySessionScreen> {
  static final _log = Logger('PlaySessionScreen');

  bool _duringCelebration = false;
  late DateTime _startOfPlay;

  @override
  void initState() {
    super.initState();
    _startOfPlay = DateTime.now();
    // todo: 인앱결제 후 구현
  }

  Future<void> _playWon() async {
    _log.info('Level ${widget.level.number} won');

    final score = Score(
      widget.level.number,
      widget.level.difficulty,
      DateTime.now().difference(_startOfPlay),
    );

    final playerProgress = context.read<PlayerProgress>();
    playerProgress.setLevelReached(widget.level.number);

    await Future<void>.delayed(AppCfg.durationPreCelebration);
    if (!mounted) return;

    setState(() => _duringCelebration = true);

    // todo: AudioController 구현 후..
    // todo: GamesServicesController 구현 후..

    await Future<void>.delayed(AppCfg.durationCelebration);
    if (!mounted) return;

    context.go('/play/won', extra: {'score': score});
  }

  // todo: 여기서부터 하자~~~~~~~~~~~
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

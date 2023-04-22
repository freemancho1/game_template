import 'package:flutter/material.dart';
import 'package:game_template/config.dart';
import 'package:game_template/src/games_services/level_state.dart';
import 'package:game_template/src/games_services/score.dart';
import 'package:game_template/src/level_selection/levels.dart';
import 'package:game_template/src/player_progress/player_progress.dart';
import 'package:game_template/src/style/confetti.dart';
import 'package:game_template/src/style/palette.dart';
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

  Future<void> _playerWon() async {
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

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LevelState(
            onWin: _playerWon,
            goal: widget.level.difficulty,
          ),
        )
      ],
      child: IgnorePointer(
        ignoring: _duringCelebration,
        child: Scaffold(
          backgroundColor: palette.backgroundPlaySession,
          body: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkResponse(
                        onTap: () => context.go('/settings'),
                        child: Image.asset(
                          'assets/images/settings.png',
                          semanticLabel: 'Settings',
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text('${widget.level.difficulty}%까지 이동하세요.'),
                    Consumer<LevelState>(
                      builder: (context, levelState, child) => Slider(
                        label: 'Level Progress',
                        autofocus: true,
                        value: levelState.progress / 100,
                        onChanged: (value) =>
                          levelState.setProgress((value*100).round()),
                        onChangeEnd: (value) => levelState.evaluate(),
                      )
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(AppCfg.baseEdgeSize),
                      child: SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () => context.go('/play'),
                          child: const Text('Back'),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox.expand(
                child: Visibility(
                  visible: _duringCelebration,
                  child: IgnorePointer(
                    child: Confetti(
                      isStopped: !_duringCelebration,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

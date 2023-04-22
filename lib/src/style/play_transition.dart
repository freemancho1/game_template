import 'package:flutter/material.dart';
import 'package:game_template/config.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';

// todo: <T> 사용법 확인
CustomTransitionPage<T> buildPlayTransition<T>({
  required Widget child,
  required Color color,
  String? name,
  Object? arguments,
  String? restorationId,
  LocalKey? key,
}) => CustomTransitionPage<T>(
  child: child,
  transitionsBuilder: (context, animation, secondaryAnimation, child) =>
    _PlayReveal(animation: animation, color: color, child: child,),
  key: key,
  name: name,
  arguments: arguments,
  restorationId: restorationId,
  transitionDuration: AppCfg.pageTransitionDuration,
);

class _PlayReveal extends StatefulWidget {
  final Widget child;
  final Animation<double> animation;
  final Color color;
  const _PlayReveal({
    required this.child,
    required this.animation,
    required this.color,
  });

  @override
  State<_PlayReveal> createState() => _PlayRevealState();
}

class _PlayRevealState extends State<_PlayReveal> {
  static final _log = Logger('_PlayRevelState');

  bool _finished = false;
  final _tween = Tween(begin: const Offset(0, -1), end: Offset.zero);

  void _statusListener(AnimationStatus status) {
    _log.info('status: $status');
    switch (status) {
      case AnimationStatus.completed:
        setState(() => _finished = true);
        break;
      case AnimationStatus.forward:
      case AnimationStatus.dismissed:
      case AnimationStatus.reverse:
        setState(() => _finished = false);
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    widget.animation.addStatusListener(_statusListener);
  }

  @override
  void didUpdateWidget(covariant _PlayReveal oldWidget) {
    if (oldWidget.animation != widget.animation) {
      oldWidget.animation.removeStatusListener(_statusListener);
      widget.animation.addStatusListener(_statusListener);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    widget.animation.removeStatusListener(_statusListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Stack(
    fit: StackFit.expand,
    children: [
      SlideTransition(
        position: _tween.animate(
          CurvedAnimation(
            parent: widget.animation,
            curve: Curves.easeOutCubic
          ),
        ),
        child: Container(color: widget.color,),
      ),
      AnimatedOpacity(
        opacity: _finished ? 1 : 0,
        duration: AppCfg.pageOpacityDuration,
        child: widget.child,
      ),
    ],
  );
}


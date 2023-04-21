import 'package:flutter/material.dart';
import 'package:game_template/config.dart';
import 'package:logging/logging.dart';

class ResponsiveScreenLayout extends StatelessWidget {
  final Widget squarishMainArea;
  final Widget rectangularMenuArea;
  final Widget topMessageArea;
  final double mainAreaProminence;
  const ResponsiveScreenLayout({
    super.key,
    required this.squarishMainArea,
    required this.rectangularMenuArea,
    this.topMessageArea = const SizedBox.shrink(),
    this.mainAreaProminence = 0.8,
  });

  static final Logger _log = Logger('ResponsiveScreenLayout');

  @override
  Widget build(BuildContext context) {
    _log.info('++ 반응형 레이아웃 구성 시작');
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest;
        _log.info('++ 화면 크기: ${size.toString()}');
        final padding = EdgeInsets.all(size.shortestSide / 30);

        if (size.height >= size.width) {
          _log.info('++ 세로화면');
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SafeArea(
                bottom: false,
                child: Padding(
                  padding: padding,
                  child: topMessageArea,
                ),
              ),
              Expanded(
                flex: (mainAreaProminence * 100).round(),
                child: SafeArea(
                  top: false, bottom: false, minimum: padding,
                  child: squarishMainArea,
                )
              ),
              SafeArea(
                top: false, maintainBottomViewPadding: true,
                child: Padding(
                  padding: padding,
                  child: rectangularMenuArea,
                ),
              )
            ],
          );
        } else {
          final bool isLarge = size.width > AppCfg.largeWidth;
          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: isLarge ? 7: 5,
                child: SafeArea(
                  right: false, maintainBottomViewPadding: true,
                  minimum: padding,
                  child: squarishMainArea,
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    SafeArea(
                      bottom: false, left: false,
                      maintainBottomViewPadding: true,
                      child: Padding(
                        padding: padding,
                        child: topMessageArea,
                      ),
                    ),
                    Expanded(
                      child: SafeArea(
                        top: false, left: false,
                        maintainBottomViewPadding: true,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: padding,
                            child: rectangularMenuArea,
                          ),
                        ),
                      )
                    ),
                  ],
                ),
              )
            ],
          );
        }
      }
    );
  }
}

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

class AppLifecycleObserver extends StatefulWidget {
  final Widget child;
  const AppLifecycleObserver({
    super.key,
    required this.child,
  });

  @override
  State<AppLifecycleObserver> createState() => _AppLifecycleObserverState();
}

class _AppLifecycleObserverState extends State<AppLifecycleObserver>
  with WidgetsBindingObserver {
  static final _log = Logger('App Lifecycle Observer');

  final ValueNotifier<AppLifecycleState> lifecycleListenable =
    ValueNotifier(AppLifecycleState.inactive);

  @override
  Widget build(BuildContext context) {
    /// 이 코드는 InheritedProvider를 사용하여 Consumer나 context.watch 등을
    /// 사용하지 않고 이를 수동으로 추가하여 수명주기 상태 변경의 이벤트에 관심을 갖습니다.
    /// 상태 자체보다는 상태 변경의 이벤트를 처리하고 있습니다.
    /// (예를 들어, 앱이 백그라운드로 전환되면 소리를 중지하고 앱이 다시 포커스 될 때
    /// 소리를 다시 시작합니다. 위젯을 다시 빌드하지는 않습니다.)
    ///
    /// Provider는 기본적으로 ValueNotifier와 같은 Listenable을 제공 할 때
    /// ValueListenableProvider와 같은 것을 사용하지 않으면 예외를 발생시킵니다.
    /// InheritedProvider는 더 낮은 수준의 Provider로, 이러한 문제가 없습니다.
    return InheritedProvider<ValueNotifier<AppLifecycleState>>.value(
      value: lifecycleListenable,
      child: widget.child,
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _log.info('++ AppLifecycleState 변경전: state = '
              '[${lifecycleListenable.value}]');
    _log.info('++ AppLifecycleState 변경후: state = [$state]');
    lifecycleListenable.value = state;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _log.info('++ 앱 수명주기 업데이트를 구독했습니다.');
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _log.info('++ 앱 수명주기 업데이트 구독을 취소했습니다.');
    super.dispose();
  }
}

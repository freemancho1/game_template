import 'dart:async';
import 'dart:isolate';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

/// mainFunction을 실행한다.
Future<void> guardWithCrashlytics(
  void Function() mainFunction, {
  required FirebaseCrashlytics? crashlytics,}) async {

  await runZonedGuarded<Future<void>>(() async {
    if (kDebugMode) {
      Logger.root.level = Level.FINE;
    }

    Logger.root.onRecord.listen((record) {
      final message = '${record.level.name}: ${record.time}: '
          '${record.loggerName}: ${record.message}';
      debugPrint(message);
      crashlytics?.log(message);
      if (record.level >= Level.SEVERE) {
        crashlytics?.recordError(
          message,
          filterStackTrace(StackTrace.current),
          fatal: true
        );
      }
    });

    if (crashlytics != null) {
      WidgetsFlutterBinding.ensureInitialized();
      FlutterError.onError = crashlytics.recordFlutterFatalError;
    }

    if (!kIsWeb) {
      Isolate.current.addErrorListener(RawReceivePort((dynamic pair) async {
        final errorAndStacktrace = pair as List<dynamic>;
        await crashlytics?.recordError(
          errorAndStacktrace.first,
          errorAndStacktrace.last as StackTrace?,
          fatal: true
        );
      }).sendPort);
    }

    mainFunction();

  }, (error, stack) {
    debugPrint('ERROR: $error\n\nSTACK: $stack');
    crashlytics?.recordError(error, stack, fatal: true);
  });
}

/// StackTrace에서 특정 문자열이 포함된 라인을 제거하고 StackTrace를 재 구성함.
@visibleForTesting
StackTrace filterStackTrace(StackTrace stackTrace) {
  final List<String> excludes = [
    'crashlytics.dart', '_BroadcastStreamController.java', 'logger.dart',
  ];
  try {
    final lines = stackTrace.toString().split('\n');
    final buf = StringBuffer();
    for (final line in lines) {
      if (excludes.any((e) => line.contains(e))) {
        continue;
      }
      buf.writeln(line);
    }
    return StackTrace.fromString(buf.toString());
  } catch(e) {
    debugPrint('StackTrace 필터링 중 문제가 발생했습니다: $e');
  }
  return stackTrace;
}
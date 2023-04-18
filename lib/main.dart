
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:game_template/src/utils/crashlytics.dart';

Future<void> main() async {
  FirebaseCrashlytics? crashlytics;
  await guardWithCrashlytics(guardedMain, crashlytics: crashlytics);
}

void guardedMain() {

}
import 'package:logging/logging.dart';

void main() {
  Logger _log = Logger('test.main.dart');
  Logger.root.level = Level.ALL;
  _log.finest('FINEST message');
  _log.finer('FINER message');
  _log.fine('FINE message');
  _log.config('CONFIG message');
  _log.info('INFO message');
  _log.warning('WARNING message');
  _log.severe('SEVERE message');
  _log.shout('SHOUT message');
}
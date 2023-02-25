import 'package:logger/logger.dart';

class AppLogger {
  static void error(error, [stackTrace]) {
    final logger = Logger();
    logger.e([error, stackTrace], error);
  }
}

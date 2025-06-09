import 'package:logger/logger.dart';

class LogService {
  static final LogService _instance = LogService._();

  LogService._() {
    _initConsoleLogger();
  }

  factory LogService() => _instance;

  late final Logger _consoleLogger;

  void _initConsoleLogger() {
    _consoleLogger = Logger(
      level: Logger.level,
      printer: PrettyPrinter(
        colors: true,
        methodCount: 2,
        noBoxingByDefault: false,
        printEmojis: true,
      ),
    );
  }

  void logMessage(String message) => d(message);

  void logError(String message, Object? error, StackTrace? s) =>
      e(message, error: error, s: s);

  void d(String message) => _consoleLogger.d(message);

  void i(String message) => _consoleLogger.i(message);

  void w(String message) => _consoleLogger.w(message);

  void e(String message, {Object? error, StackTrace? s}) =>
      _consoleLogger.e(message, error: error, stackTrace: s);
}

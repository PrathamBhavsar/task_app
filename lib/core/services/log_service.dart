import 'package:logger/logger.dart';

class LogService {
  static final LogService _instance = LogService._();

  LogService._() {
    _initConsoleLogger();
  }

  factory LogService() => _instance;

  Logger? _consoleLogger;

  void _initConsoleLogger() {
    _consoleLogger = Logger(
      output: ConsoleOutput(),
      printer: PrettyPrinter(colors: false, printEmojis: false, methodCount: 1),
    );
  }

  void logMessage(String message) => d(message);

  void logError(String message, Object? error, StackTrace? stackTrace) =>
      e(message, error: error, stackTrace: stackTrace);

  void d(String message) {
    _consoleLogger?.d(message, time: DateTime.now());
  }

  void i(String message) {
    _consoleLogger?.i(message, time: DateTime.now());
  }

  void w(String message) {
    _consoleLogger?.w(message, time: DateTime.now());
  }

  void e(String message, {Object? error, StackTrace? stackTrace}) {
    _consoleLogger?.e(
      message,
      error: error,
      stackTrace: stackTrace,
      time: DateTime.now(),
    );
  }
}

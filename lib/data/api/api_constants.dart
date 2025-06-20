class ApiConstants {
  /// Base URLs
  static const String _localDomainUrl = "http://192.168.1.6:8000";
  static const String _developmentDomainUrl = "";

  static String currentDomainBaseUrl = _localDomainUrl;

  static String get currentBaseUrl => "$currentDomainBaseUrl/api";

  static void useDevelopment() => currentDomainBaseUrl = _developmentDomainUrl;
  static void useLocal() => currentDomainBaseUrl = _localDomainUrl;

  static String _build(String path) => "$currentBaseUrl$path";

  static final user = _UserRoutes();
  static final task = _GenericRoutes("/task");
  static final designer = _GenericRoutes("/designer");
  static final client = _GenericRoutes("/client");
  static final status = _GenericRoutes("/status");
  static final priorities = _GenericRoutes("/priority");
  static final measurement = _GenericRoutes("/measurement");
  static final service = _GenericRoutes("/service");
  static final bill = _GenericRoutes("/bill");
}

/// User-specific routes
class _UserRoutes {
  String get base => ApiConstants._build("/user");
  String get register => ApiConstants._build("/user/register");
  String get login => ApiConstants._build("/user/login");
  String get update => ApiConstants._build("/user/update");
  String get delete => ApiConstants._build("/user/delete");
}

/// Generic structure
class _GenericRoutes {
  final String path;

  _GenericRoutes(this.path);

  String get base => ApiConstants._build(path);
  String get update => ApiConstants._build("$path/update");
  String get delete => ApiConstants._build("$path/delete");

  /// Custom endpoint
  String endpoint(String subPath) => ApiConstants._build("$path/$subPath");
}

class ApiConstants {
  /// Base URLs
  static const String _localDomainUrl = "http://192.168.1.7:8000";
  static const String _developmentDomainUrl = "";

  static String currentDomainBaseUrl = _localDomainUrl;

  static String get currentBaseUrl => "$currentDomainBaseUrl/api";

  static void useDevelopment() => currentDomainBaseUrl = _developmentDomainUrl;

  static void useLocal() => currentDomainBaseUrl = _localDomainUrl;

  static String _build(String path) => "$currentBaseUrl$path";

  static final user = _GenericRoutes("/user");
  static final auth = _GenericRoutes("/auth");
  static final task = _GenericRoutes("/task");
  static final designer = _GenericRoutes("/designer");
  static final client = _GenericRoutes("/client");
  static final measurement = _GenericRoutes("/measurement");
  static final service = _GenericRoutes("/service");
  static final serviceMaster = _GenericRoutes("/service-master");
  static final bill = _GenericRoutes("/bill");
  static final quote = _GenericRoutes("/quote");
  static final timeline = _GenericRoutes("/timeline");
  static final message = _GenericRoutes("/message");
}

/// Generic structure
class _GenericRoutes {
  final String path;

  _GenericRoutes(this.path);

  String get base => ApiConstants._build(path);

  String get update => ApiConstants._build("$path/update");

  String get login => ApiConstants._build("$path/login");

  String get register => ApiConstants._build("$path register");

  /// Custom endpoint
  String endpoint(String subPath) => ApiConstants._build("$path/$subPath");
}

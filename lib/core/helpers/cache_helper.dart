import '../../domain/entities/service_master.dart';
import '../../domain/entities/user.dart';
import '../../utils/enums/user_role.dart';
import 'secure_prefs_helper.dart';
import 'shared_prefs_helper.dart';

class CacheHelper {
  final SharedPrefHelper _prefs;
  final SecurePrefHelper _securePrefs;

  CacheHelper(this._prefs, this._securePrefs);

  User? _user;
  List<ServiceMaster>? _serviceMasters;
  String? _token;
  String? _refToken;

  void setToken(String userToken) {
    _token = userToken;
    _securePrefs.saveToken(userToken);
  }

  Future<String?> getToken() async {
    _token = await _securePrefs.getToken();
    return _token;
  }

  void setRefToken(String refToken) {
    _refToken = refToken;
    _securePrefs.saveRefreshToken(refToken);
  }

  Future<String?> getRefToken() async {
    _refToken = await _securePrefs.getRefToken();
    return _refToken;
  }

  Future<User?> getInitUser() async {
    _user = await _prefs.getUser();
    return _user;
  }

  void setUser(User user) {
    _user = user;
    _prefs.saveUser(user);
  }

  UserRole getUserRole() => _user?.userType ?? UserRole.agent;

  int? getUserId() => _user?.userId;

  User? get user => _user;

  // Role helpers
  bool get isAdmin => getUserRole() == UserRole.admin;

  bool get isAgency => getUserRole() == UserRole.agent;

  bool get isSalesperson => getUserRole() == UserRole.salesperson;

  void setServiceMasters(List<ServiceMaster> serviceMasterList) {
    _serviceMasters = serviceMasterList;
  }

  List<ServiceMaster> getServiceMasterList() => _serviceMasters ?? [];

  void clearUser() {
    _user = null;
    _prefs.clear();
  }
}

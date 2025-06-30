import '../../domain/entities/service_master.dart';
import '../../domain/entities/user.dart';
import '../../utils/enums/user_role.dart';
import 'shared_prefs_helper.dart';

class CacheHelper {
  final SharedPrefHelper _prefs;

  CacheHelper(this._prefs);

  User? _user;
  List<ServiceMaster>? _serviceMasters;

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

  void setServiceMasters(List<ServiceMaster> serviceMasterList) {
    _serviceMasters = serviceMasterList;
  }

  List<ServiceMaster> getServiceMasterList() => _serviceMasters ?? [];

  void clearUser() {
    _user = null;
    _prefs.clear();
  }
}

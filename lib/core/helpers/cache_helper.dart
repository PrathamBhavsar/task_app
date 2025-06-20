
import '../../domain/entities/user.dart';
import '../../utils/enums/user_role.dart';
import 'shared_prefs_helper.dart';

class CacheHelper {
  final SharedPrefHelper _prefs;

  CacheHelper(this._prefs);

  User? _user;

  Future<User?> getInitUser() async {
    _user = await _prefs.getUser();
    return _user;
  }

  void setUser(User user) {
    _user = user;
    _prefs.saveUser(user);
  }

  UserRole getUserRole() => _user?.userType ?? UserRole.agent;

  User? get user => _user;

  // int getUserId() => _user?.id ?? 0;

  // UserRole? getUserRole() => _user?.userType ?? UserRole.agent.role;

  void clearUser() {
    _user = null;
    _prefs.clear();
  }
}

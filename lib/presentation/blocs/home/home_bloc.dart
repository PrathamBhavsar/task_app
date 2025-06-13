import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/helpers/cache_helper.dart';
import '../../../utils/enums/user_role.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final CacheHelper _cache;

  HomeBloc(this._cache)
    : super(const HomeState(userRole: UserRole.salesperson, barIndex: 0)) {
    on<LoadUserRoleEvent>(_onLoadUserRole);
    on<SetUserRoleEvent>(_onSetUserRole);
    on<SetBarIndexEvent>(_onSetBarIndex);
  }

  Future<void> _onLoadUserRole(
    LoadUserRoleEvent event,
    Emitter<HomeState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final roleString = prefs.getString('userRole');
    final role = UserRole.values.firstWhere(
      (e) => e.toString() == roleString,
      orElse: () => UserRole.admin,
    );
    emit(state.copyWith(userRole: role));
  }

  Future<void> _onSetUserRole(
    SetUserRoleEvent event,
    Emitter<HomeState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userRole', event.role.toString());
    emit(state.copyWith(userRole: event.role));
  }

  void _onSetBarIndex(SetBarIndexEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(barIndex: event.index));
  }
}

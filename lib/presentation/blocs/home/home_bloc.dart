import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/enums/user_role.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc()
    : super(
        const HomeState(
          userRole: UserRole.salesperson,
          barIndex: 0,
          isActive: true,
        ),
      ) {
    on<LoadUserRoleEvent>(_onLoadUserRole);
    on<SetUserRoleEvent>(_onSetUserRole);
    on<SetBarIndexEvent>(_onSetBarIndex);
    on<ToggleActiveEvent>(_onToggleActive);
    on<SetActiveEvent>(_onSetActive);
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

  void _onToggleActive(ToggleActiveEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(isActive: !state.isActive));
  }

  void _onSetActive(SetActiveEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(isActive: event.isActive));
  }
}

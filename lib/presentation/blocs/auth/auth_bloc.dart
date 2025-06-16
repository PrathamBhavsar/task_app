import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../utils/enums/user_role.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState(userRole: UserRole.admin, isVisible: false)) {
    on<SetUserRoleEvent>(_onSetUserRole);
    on<ToggleVisibilityEvent>(_onToggleVisibility);
  }

  void _onSetUserRole(SetUserRoleEvent event, Emitter<AuthState> emit) {
    emit(state.copyWith(userRole: event.role));
  }

  void _onToggleVisibility(
    ToggleVisibilityEvent event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(isVisible: !state.isVisible));
  }
}

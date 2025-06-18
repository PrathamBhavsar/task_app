import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../core/error/failure.dart';
import '../../../core/helpers/cache_helper.dart';
import '../../../data/models/payloads/auth_payload.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/usecases/auth_usecase.dart';
import '../../../utils/enums/user_role.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUseCase _authUseCase;
  final CacheHelper _cache;

  AuthBloc(this._cache, this._authUseCase) : super(AuthState.initial()) {
    on<SetUserRoleEvent>(_onSetUserRole);
    on<ToggleVisibilityEvent>(_onToggleVisibility);
    on<LoginEvent>(_onLogin);
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

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final authPayload = AuthPayload(
        email: event.email,
        password: event.password,
      );

      final result = await _authUseCase(authPayload);

      result.fold(
        (failure) =>
            emit(state.copyWith(status: AuthStatus.failure, error: failure)),
        (user) {
          emit(state.copyWith(status: AuthStatus.success, user: user));
          _cache.setUser(user);
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          error: Failure(e.toString()),
        ),
      );
    }
  }
}

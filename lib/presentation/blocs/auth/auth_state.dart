part of 'auth_bloc.dart';

enum AuthStatus { initial, loading, success, failure }

@immutable
class AuthState {
  final AuthStatus status;
  final UserRole userRole;
  final bool isVisible;
  final User? user;
  final Failure? error;

  const AuthState({
    required this.status,
    required this.userRole,
    required this.isVisible,
    this.user,
    this.error,
  });

  factory AuthState.initial() => const AuthState(
    status: AuthStatus.initial,
    userRole: UserRole.admin,
    isVisible: false,
    user: null,
    error: null,
  );

  AuthState copyWith({
    AuthStatus? status,
    UserRole? userRole,
    bool? isVisible,
    User? user,
    Failure? error,
  }) {
    return AuthState(
      status: status ?? this.status,
      userRole: userRole ?? this.userRole,
      isVisible: isVisible ?? this.isVisible,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }
}

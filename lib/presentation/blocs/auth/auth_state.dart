part of 'auth_bloc.dart';

@immutable
class AuthState {
  final UserRole userRole;
  final bool isVisible;

  const AuthState({required this.userRole, required this.isVisible});

  AuthState copyWith({UserRole? userRole, bool? isVisible}) {
    return AuthState(
      userRole: userRole ?? this.userRole,
      isVisible: isVisible ?? this.isVisible,
    );
  }
}

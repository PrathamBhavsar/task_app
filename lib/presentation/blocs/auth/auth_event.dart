part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class ToggleVisibilityEvent extends AuthEvent {}

class SetUserRoleEvent extends AuthEvent {
  final UserRole role;
  SetUserRoleEvent(this.role);
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}

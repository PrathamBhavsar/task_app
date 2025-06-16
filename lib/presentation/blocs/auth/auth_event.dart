part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class ToggleVisibilityEvent extends AuthEvent {
  ToggleVisibilityEvent();
}

class SetUserRoleEvent extends AuthEvent {
  final UserRole role;

  SetUserRoleEvent(this.role);
}

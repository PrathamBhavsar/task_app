part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class ToggleVisibilityEvent extends AuthEvent {
  final bool isVisible;

  ToggleVisibilityEvent(this.isVisible);
}

class SetUserRoleEvent extends AuthEvent {
  final UserRole role;

  SetUserRoleEvent(this.role);
}

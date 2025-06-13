import 'package:flutter/foundation.dart';

import '../../../utils/enums/user_role.dart';

@immutable
abstract class HomeEvent {}

class LoadUserRoleEvent extends HomeEvent {}

class SetUserRoleEvent extends HomeEvent {
  final UserRole role;

  SetUserRoleEvent(this.role);
}

class SetBarIndexEvent extends HomeEvent {
  final int index;

  SetBarIndexEvent(this.index);
}

class ToggleActiveEvent extends HomeEvent {}

class SetActiveEvent extends HomeEvent {
  final bool isActive;

  SetActiveEvent(this.isActive);
}

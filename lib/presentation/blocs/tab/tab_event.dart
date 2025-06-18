part of 'tab_bloc.dart';

@immutable
abstract class TabEvent {}

class ToggleVisibilityEvent extends TabEvent {}

class SetTabIndex extends TabEvent {
  final int tabIndex;

  SetTabIndex(this.tabIndex);
}

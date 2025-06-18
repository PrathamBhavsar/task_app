part of 'tab_bloc.dart';

enum TabStatus { initial, loading, success, failure }

@immutable
class TabState {
  final int tabIndex;

  const TabState({required this.tabIndex});

  factory TabState.initial() => const TabState(tabIndex: 0);

  TabState copyWith({int? tabIndex}) {
    return TabState(tabIndex: tabIndex ?? this.tabIndex);
  }
}

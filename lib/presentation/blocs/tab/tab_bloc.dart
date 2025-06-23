import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';


part 'tab_event.dart';

part 'tab_state.dart';

class TabBloc extends Bloc<TabEvent, TabState> {
  TabBloc() : super(TabState.initial()) {
    on<SetTabIndex>(_onSetTabIndex);
  }

  void _onSetTabIndex(SetTabIndex event, Emitter<TabState> emit) {
    emit(state.copyWith(tabIndex: event.tabIndex));
  }
}

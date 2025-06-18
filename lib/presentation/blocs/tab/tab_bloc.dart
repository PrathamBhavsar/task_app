import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../core/error/failure.dart';
import '../../../core/helpers/cache_helper.dart';
import '../../../data/models/payloads/auth_payload.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/usecases/auth_usecase.dart';
import '../../../utils/enums/user_role.dart';

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

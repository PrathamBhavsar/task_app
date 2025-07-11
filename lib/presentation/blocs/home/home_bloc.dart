import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/helpers/cache_helper.dart';
import '../../../utils/enums/user_role.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  HomeBloc()
    : super(const HomeState(userRole: UserRole.admin, barIndex: 0)) {
    on<SetBarIndexEvent>(_onSetBarIndex);
  }

  void _onSetBarIndex(SetBarIndexEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(barIndex: event.index));
  }
}

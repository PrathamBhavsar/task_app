import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/user_usecase.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetAllUsersUseCase _getAllUsersUseCase;

  UserBloc(this._getAllUsersUseCase) : super(UserInitial()) {
    on<FetchUsersRequested>(_onFetchUsers);
  }

  Future<void> _onFetchUsers(
    FetchUsersRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoadInProgress());
    final result = await _getAllUsersUseCase();
    result.fold(
      (failure) => emit(UserLoadFailure(failure)),
      (users) => emit(UserLoadSuccess(users)),
    );
  }
}

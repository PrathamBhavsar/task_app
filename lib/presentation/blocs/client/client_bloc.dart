
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/client_usecase.dart';
import 'client_event.dart';
import 'client_state.dart';


class ClientBloc extends Bloc<ClientEvent, ClientState> {
  final GetAllClientsUseCase _getAllClientsUseCase;

  ClientBloc(this._getAllClientsUseCase) : super(ClientInitial()) {
    on<FetchClientsRequested>(_onFetchClients);
  }

  Future<void> _onFetchClients(
      FetchClientsRequested event,
      Emitter<ClientState> emit,
      ) async {
    emit(ClientLoadInProgress());
    final result = await _getAllClientsUseCase();
    result.fold(
          (failure) => emit(ClientLoadFailure(failure)),
          (clients) => emit(ClientLoadSuccess(clients)),
    );
  }
}


import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/client_usecase.dart';
import '../../../domain/usecases/put_client_usecase.dart';
import 'client_event.dart';
import 'client_state.dart';


class ClientBloc extends Bloc<ClientEvent, ClientState> {
  final GetAllClientsUseCase _getAllClientsUseCase;
  final PutClientUseCase _putClientUseCase;

  ClientBloc(this._getAllClientsUseCase, this._putClientUseCase) : super(ClientInitial()) {
    on<FetchClientsRequested>(_onFetchClients);
    on<PutClientRequested>(_onPutClient);

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

  Future<void> _onPutClient(
      PutClientRequested event,
      Emitter<ClientState> emit,
      ) async {
    emit(ClientLoadInProgress());
    final result = await _putClientUseCase(event.data);
    result.fold(
          (failure) => emit(PutClientFailure(failure)),
          (clients) => emit(PutClientSuccess(clients)),
    );
  }
}

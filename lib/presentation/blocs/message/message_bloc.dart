import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/message_usecase.dart';
import 'message_event.dart';
import 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final GetAllMessagesUseCase _getAllMessagesUseCase;

  MessageBloc(this._getAllMessagesUseCase) : super(MessageInitial()) {
    on<FetchMessagesRequested>(_onFetchMessages);
  }

  Future<void> _onFetchMessages(
      FetchMessagesRequested event,
      Emitter<MessageState> emit,
      ) async {
    emit(MessageLoadInProgress());

    final result = await _getAllMessagesUseCase(event.taskId);

    result.fold(
          (failure) => emit(MessageLoadFailure(failure)),
          (messages) => emit(MessageLoadSuccess(messages)),
    );
  }
}

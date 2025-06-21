import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/message_usecase.dart';
import '../../../domain/usecases/put_message_usecase.dart';
import 'message_event.dart';
import 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final GetAllMessagesUseCase _getAllMessagesUseCase;
  final PutMessageUseCase _putMessageUseCase;

  MessageBloc(this._getAllMessagesUseCase, this._putMessageUseCase) : super(MessageInitial()) {
    on<FetchMessagesRequested>(_onFetchMessages);
    on<PutMessageRequested>(_onPutMessage);
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

  Future<void> _onPutMessage(
      PutMessageRequested event,
      Emitter<MessageState> emit,
      ) async {
    emit(MessageLoadInProgress());

    final result = await _putMessageUseCase(event.data);

    result.fold(
          (failure) => emit(PutMessageFailure(failure)),
          (message) {
            emit(PutMessageSuccess(message));
          },
    );
  }
}

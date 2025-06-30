import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/quote_usecase.dart';
import 'quote_event.dart';
import 'quote_state.dart';

class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  final GetAllQuotesUseCase _getAllQuotesUseCase;

  QuoteBloc(this._getAllQuotesUseCase) : super(QuoteInitial()) {
    on<FetchQuotesRequested>(_onFetchQuotes);
  }

  Future<void> _onFetchQuotes(
    FetchQuotesRequested event,
    Emitter<QuoteState> emit,
  ) async {
    emit(QuoteLoadInProgress());
    final result = await _getAllQuotesUseCase(event.taskId);
    result.fold(
      (failure) => emit(QuoteLoadFailure(failure)),
      (quotes) => emit(QuoteLoadSuccess(quotes)),
    );
  }
}

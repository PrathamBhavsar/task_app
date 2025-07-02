// quote_api_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/quote_usecase.dart';
import '../../../domain/usecases/update_quote_measurement_usecase.dart';
import '../../../domain/usecases/update_quote_usecase.dart';
import 'quote_api_event.dart';
import 'quote_api_state.dart';

class QuoteApiBloc extends Bloc<QuoteApiEvent, QuoteApiState> {
  final GetAllQuotesUseCase _getAllQuotesUseCase;
  final UpdateQuoteUseCase _updateQuoteUseCase;
  final UpdateQuoteMeasurementUseCase _updateQuoteMeasurementUseCase;

  QuoteApiBloc(this._getAllQuotesUseCase, this._updateQuoteUseCase, this._updateQuoteMeasurementUseCase)
      : super(QuoteApiInitial()) {
    on<FetchQuotesRequested>(_onFetchQuotes);
    on<UpdateQuoteRequested>(_onUpdateQuote);
    on<UpdateQuoteMeasurementsRequested>(_onUpdateQuoteMeasurement);
  }

  Future<void> _onFetchQuotes(
      FetchQuotesRequested event,
      Emitter<QuoteApiState> emit,
      ) async {
    emit(QuoteApiLoading());
    final result = await _getAllQuotesUseCase(event.taskId);

    result.fold(
          (failure) => emit(QuoteApiFailure(failure)),
          (quote) => emit(QuoteApiLoaded(quote)),
    );
  }

  Future<void> _onUpdateQuote(
      UpdateQuoteRequested event,
      Emitter<QuoteApiState> emit,
      ) async {
    emit(QuoteApiLoading());
    final result = await _updateQuoteUseCase(event.data);

    result.fold(
          (failure) => emit(QuoteApiFailure(failure)),
          (quote) => emit(QuoteApiUpdated(quote)),
    );
  }
  Future<void> _onUpdateQuoteMeasurement(
      UpdateQuoteMeasurementsRequested event,
      Emitter<QuoteApiState> emit,
      ) async {
    emit(QuoteApiLoading());
    final result = await _updateQuoteMeasurementUseCase(event.data);

    result.fold(
          (failure) => emit(QuoteApiFailure(failure)),
          (quote) => emit(QuoteApiUpdated(quote)),
    );
  }
}

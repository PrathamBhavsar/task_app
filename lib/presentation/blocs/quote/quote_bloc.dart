import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/error/failure.dart';
import '../../../domain/entities/quote.dart';
import '../../../domain/entities/quote_measurement.dart';
import '../../../domain/usecases/quote_usecase.dart';
import 'quote_event.dart';
import 'quote_state.dart';

class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  final GetAllQuotesUseCase _getAllQuotesUseCase;

  QuoteBloc(this._getAllQuotesUseCase) : super(QuoteInitial()) {
    on<FetchQuotesRequested>(_onFetchQuotes);
    on<InitializeQuotes>(_onInitializeQuotes);
    on<QuoteMeasurementFieldUpdated>(_onQuoteMeasurementUpdated);
    on<QuoteUpdated>(_onQuoteUpdated);
  }

  void _onQuoteUpdated(QuoteUpdated event, Emitter<QuoteState> emit) {

    final currentState = state as QuoteLoadSuccess;
    final oldQuote = currentState.quote;

    final List<QuoteMeasurement> measurements = currentState.quoteMeasurements;

    final double subtotal = measurements.fold(
      0.0,
      (sum, qm) => sum + qm.totalPrice,
    );

    final double? discountPercent = event.discount ?? oldQuote?.discount;
    final double discountedSubtotal =
        discountPercent != null
            ? subtotal * (1 - discountPercent / 100)
            : subtotal;

    final double tax = discountedSubtotal * 0.07;
    final double total = discountedSubtotal + tax;

    emit(
      currentState.copyWith(
        quote: Quote(
          taskId: oldQuote?.taskId ?? currentState.task.taskId!,
          subtotal: discountedSubtotal,
          discount: discountPercent,
          tax: tax,
          total: total,
          createdAt: oldQuote?.createdAt ?? DateTime.now(),
        ),
      ),
    );
  }

  void _onQuoteMeasurementUpdated(
    QuoteMeasurementFieldUpdated event,
    Emitter<QuoteState> emit,
  ) {
    if (state is! QuoteLoadSuccess) {
      return;
    }

    final currentState = state as QuoteLoadSuccess;
    final oldQuote = currentState.quote;

    final updatedQuoteMeasurements = List<QuoteMeasurement>.from(
      currentState.quoteMeasurements,
    );

    final old = updatedQuoteMeasurements[event.index];

    final double newRate = event.rate ?? old.rate;
    final double newDiscount = event.discount ?? old.discount;
    final int newQty = event.quantity ?? old.quantity;
    final double newTotalPrice = (newRate * newQty) * (1 - newDiscount / 100);

    final double priceDifference = newTotalPrice - old.totalPrice;

    updatedQuoteMeasurements[event.index] = old.copyWith(
      rate: newRate,
      quantity: newQty,
      discount: newDiscount,
      totalPrice: newTotalPrice,
    );

    final double oldSubtotal = oldQuote?.subtotal ?? 0.0;
    final double updatedSubtotal = oldSubtotal + priceDifference;

    final double updatedTax = updatedSubtotal * 0.07;
    final double updatedTotal = updatedSubtotal + updatedTax;

    emit(
      currentState.copyWith(
        quoteMeasurements: updatedQuoteMeasurements,
        quote: Quote(
          taskId: oldQuote?.taskId ?? currentState.task.taskId!,
          subtotal: updatedSubtotal,
          tax: updatedTax,
          total: updatedTotal,
          createdAt: oldQuote?.createdAt ?? DateTime.now(),
        ),
      ),
    );
  }

  Future<void> _onFetchQuotes(
    FetchQuotesRequested event,
    Emitter<QuoteState> emit,
  ) async {
    emit(QuoteLoadInProgress());
    final result = await _getAllQuotesUseCase(event.taskId);
    result.fold((failure) => emit(QuoteLoadFailure(failure)), (quotes) {
      final currentState = state;
      if (currentState is QuoteLoadSuccess) {
        emit(
          QuoteLoadSuccess(
            task: currentState.task,
            services: currentState.services,
            measurements: currentState.measurements,
            quoteMeasurements: currentState.quoteMeasurements,
            quote: quotes,
          ),
        );
      } else {
        emit(QuoteLoadFailure(Failure("No context for quote")));
      }
    });
  }

  Future<void> _onInitializeQuotes(
    InitializeQuotes event,
    Emitter<QuoteState> emit,
  ) async {
    final services = event.services;
    final measurements = event.measurements;

    final quoteMeasurements =
        measurements
            .map((m) => QuoteMeasurement.empty(event.task.taskId!, m))
            .toList();

    emit(
      QuoteLoadSuccess(
        task: event.task,
        services: event.services,
        measurements: event.measurements,
        quoteMeasurements: quoteMeasurements,
        quote: null,
      ),
    );
  }
}

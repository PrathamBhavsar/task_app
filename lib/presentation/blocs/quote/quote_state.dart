import '../../../core/error/failure.dart';
import '../../../domain/entities/quote.dart';

abstract class QuoteState {}
class QuoteInitial extends QuoteState {}
class QuoteLoadInProgress extends QuoteState {}
class QuoteLoadSuccess extends QuoteState {
  final Quote quote;
  QuoteLoadSuccess(this.quote);
}
class QuoteLoadFailure extends QuoteState {
  final Failure error;
  QuoteLoadFailure(this.error);
}

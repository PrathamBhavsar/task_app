import '../../../core/error/failure.dart';
import '../../../domain/entities/quote.dart';

abstract class QuoteApiState {}

class QuoteApiInitial extends QuoteApiState {}

class QuoteApiLoading extends QuoteApiState {}

class QuoteApiLoaded extends QuoteApiState {
  final Quote quote;
  QuoteApiLoaded(this.quote);
}

class QuoteApiUpdated extends QuoteApiState {
  final Quote quote;
  QuoteApiUpdated(this.quote);
}

class QuoteApiFailure extends QuoteApiState {
  final Failure error;
  QuoteApiFailure(this.error);
}

abstract class QuoteEvent {}

class FetchQuotesRequested extends QuoteEvent {
  final int taskId;

  FetchQuotesRequested(this.taskId);
}

import '../../../data/models/payloads/update_quote_payload.dart';
import '../../../domain/entities/update_quote_measurement.dart';

abstract class QuoteApiEvent {}

class FetchQuotesRequested extends QuoteApiEvent {
  final int taskId;
  FetchQuotesRequested(this.taskId);
}

class UpdateQuoteRequested extends QuoteApiEvent {
  final UpdateQuotePayload data;
  UpdateQuoteRequested(this.data);
}

class UpdateQuoteMeasurementsRequested extends QuoteApiEvent {
  final List<UpdateQuoteMeasurement> data;
  UpdateQuoteMeasurementsRequested(this.data);
}

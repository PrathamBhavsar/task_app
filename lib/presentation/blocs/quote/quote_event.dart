import '../../../domain/entities/measurement.dart';
import '../../../domain/entities/service.dart';
import '../../../domain/entities/task.dart';

abstract class QuoteEvent {}

class FetchQuotesRequested extends QuoteEvent {
  final int taskId;

  FetchQuotesRequested(this.taskId);
}

class InitializeQuotes extends QuoteEvent {
  final Task task;
  final List<Measurement> measurements;
  final List<Service> services;

  InitializeQuotes(this.task, this.measurements, this.services);
}

class QuoteMeasurementFieldUpdated extends QuoteEvent {
  final int index;
  final double? rate;
  final int? quantity;
  final double? discount;

  QuoteMeasurementFieldUpdated({
    required this.index,
    this.rate,
    this.quantity,
    this.discount,
  });
}

class QuoteUpdated extends QuoteEvent {
  final double? discount;

  QuoteUpdated({this.discount});
}

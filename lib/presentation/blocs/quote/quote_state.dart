import '../../../core/error/failure.dart';
import '../../../domain/entities/measurement.dart';
import '../../../domain/entities/quote.dart';
import '../../../domain/entities/quote_measurement.dart';
import '../../../domain/entities/service.dart';
import '../../../domain/entities/task.dart';

abstract class QuoteState {}

class QuoteInitial extends QuoteState {}

class QuoteLoadInProgress extends QuoteState {}

class QuoteLoadFailure extends QuoteState {
  final Failure error;

  QuoteLoadFailure(this.error);
}

class QuoteLoadSuccess extends QuoteState {
  final Task task;
  final List<Service> services;
  final List<Measurement> measurements;
  final List<QuoteMeasurement> quoteMeasurements;
  final Quote? quote;

  QuoteLoadSuccess({
    required this.task,
    required this.services,
    required this.measurements,
    required this.quoteMeasurements,
    this.quote,
  });

  QuoteLoadSuccess copyWith({
    Task? task,
    List<Service>? services,
    List<Measurement>? measurements,
    List<QuoteMeasurement>? quoteMeasurements,
    Quote? quote,
  }) {
    return QuoteLoadSuccess(
      task: task ?? this.task,
      services: services ?? this.services,
      measurements: measurements ?? this.measurements,
      quoteMeasurements: quoteMeasurements ?? this.quoteMeasurements,
      quote: quote ?? this.quote,
    );
  }
}

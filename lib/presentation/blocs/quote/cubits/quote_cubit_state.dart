import '../../../../domain/entities/measurement.dart';
import '../../../../domain/entities/quote.dart';
import '../../../../domain/entities/quote_measurement.dart';
import '../../../../domain/entities/service.dart';
import '../../../../domain/entities/task.dart';

class QuoteCubitState {
  final Task? task;
  final List<Service> services;
  final List<Measurement> measurements;
  final List<QuoteMeasurement> quoteMeasurements;
  final Quote? quote;

  QuoteCubitState({
    this.task,
    this.services = const [],
    this.measurements = const [],
    this.quoteMeasurements = const [],
    this.quote,
  });

  factory QuoteCubitState.initial() => QuoteCubitState();

  QuoteCubitState copyWith({
    Task? task,
    List<Service>? services,
    List<Measurement>? measurements,
    List<QuoteMeasurement>? quoteMeasurements,
    Quote? quote,
  }) {
    return QuoteCubitState(
      task: task ?? this.task,
      services: services ?? this.services,
      measurements: measurements ?? this.measurements,
      quoteMeasurements: quoteMeasurements ?? this.quoteMeasurements,
      quote: quote ?? this.quote,
    );
  }
}

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
  final double? productSubtotal;
  final double? serviceSubtotal;

  factory QuoteCubitState.initial() => QuoteCubitState();

  QuoteCubitState({
    this.task,
    this.services = const [],
    this.measurements = const [],
    this.quoteMeasurements = const [],
    this.quote,
    this.productSubtotal,
    this.serviceSubtotal,
  });

  QuoteCubitState copyWith({
    Task? task,
    List<Service>? services,
    List<Measurement>? measurements,
    List<QuoteMeasurement>? quoteMeasurements,
    Quote? quote,
    double? productSubtotal,
    double? serviceSubtotal,
  }) {
    return QuoteCubitState(
      task: task ?? this.task,
      services: services ?? this.services,
      measurements: measurements ?? this.measurements,
      quoteMeasurements: quoteMeasurements ?? this.quoteMeasurements,
      quote: quote ?? this.quote,
      productSubtotal: productSubtotal ?? this.productSubtotal,
      serviceSubtotal: serviceSubtotal ?? this.serviceSubtotal,
    );
  }
}

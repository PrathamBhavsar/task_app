import '../../../core/error/failure.dart';
import '../../../domain/entities/quote_measurement.dart';

abstract class QuoteMeasurementState {}
class QuoteMeasurementInitial extends QuoteMeasurementState {}
class QuoteMeasurementLoadInProgress extends QuoteMeasurementState {}
class QuoteMeasurementLoadSuccess extends QuoteMeasurementState {
  final List<QuoteMeasurement> quoteMeasurements;
  QuoteMeasurementLoadSuccess(this.quoteMeasurements);
}
class QuoteMeasurementLoadFailure extends QuoteMeasurementState {
  final Failure error;
  QuoteMeasurementLoadFailure(this.error);
}

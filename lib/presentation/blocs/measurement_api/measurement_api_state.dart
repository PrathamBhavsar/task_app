
import '../../../core/error/failure.dart';
import '../../../domain/entities/measurement.dart';

abstract class MeasurementApiState {}

class MeasurementInitial extends MeasurementApiState {}

class MeasurementLoadInProgress extends MeasurementApiState {}

class MeasurementLoadSuccess extends MeasurementApiState {
  final List<Measurement> measurements;
  MeasurementLoadSuccess(this.measurements);
}

class MeasurementLoadFailure extends MeasurementApiState {
  final Failure error;
  MeasurementLoadFailure(this.error);
}

class PutMeasurementInProgress extends MeasurementApiState {}

class PutMeasurementSuccess extends MeasurementApiState {
  final List<Measurement> measurement;
  PutMeasurementSuccess(this.measurement);
}

class PutMeasurementFailure extends MeasurementApiState {
  final Failure error;
  PutMeasurementFailure(this.error);
}

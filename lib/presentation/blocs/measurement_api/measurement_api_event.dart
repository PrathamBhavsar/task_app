

import '../../../data/models/payloads/measurement_payload.dart';

abstract class MeasurementApiEvent {}

class FetchMeasurementsRequested extends MeasurementApiEvent {
  final int taskId;

  FetchMeasurementsRequested(this.taskId);
}

class PutMeasurementRequested extends MeasurementApiEvent {
  final MeasurementPayload data;

  PutMeasurementRequested(this.data);
}
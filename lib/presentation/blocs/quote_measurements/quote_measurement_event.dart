abstract class QuoteMeasurementEvent {}

class FetchQuoteMeasurementsRequested extends QuoteMeasurementEvent {
  final int taskId;

  FetchQuoteMeasurementsRequested(this.taskId);
}

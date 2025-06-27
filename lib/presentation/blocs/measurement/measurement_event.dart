import '../../../domain/entities/measurement.dart';
import '../../../domain/entities/service.dart';
import '../../../domain/entities/task.dart';

abstract class MeasurementEvent {}

class InitializeMeasurement extends MeasurementEvent {
  final Task existingTask;
  final List<Measurement>? measurements;
  final List<Service>? services;
  final List<String>? attachments;

  InitializeMeasurement({
    required this.existingTask,
    this.measurements,
    this.services,
    this.attachments,
  });
}

class ResetMeasurement extends MeasurementEvent {}

class MeasurementAdded extends MeasurementEvent {
  final Task task;

  MeasurementAdded(this.task);
}

class MeasurementRemoved extends MeasurementEvent {
  final int index;

  MeasurementRemoved(this.index);
}

class ServiceAdded extends MeasurementEvent {}

class ServiceRemoved extends MeasurementEvent {
  final int index;

  ServiceRemoved(this.index);
}

class AttachmentAdded extends MeasurementEvent {
  final String attachment;

  AttachmentAdded(this.attachment);
}

class AttachmentRemoved extends MeasurementEvent {
  final int index;

  AttachmentRemoved(this.index);
}

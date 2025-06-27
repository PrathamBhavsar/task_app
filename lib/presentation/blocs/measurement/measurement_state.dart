import '../../../domain/entities/measurement.dart';
import '../../../domain/entities/service.dart';

class MeasurementState {
  final List<String> attachments;
  final List<Service> services;
  final List<Measurement> measurements;
  final bool isInitialized;

  MeasurementState({
    required this.attachments,
    required this.services,
    required this.measurements,
    this.isInitialized = false,
  });

  MeasurementState copyWith({
    bool? isInitialized,
    List<String>? attachments,
    List<Service>? services,
    List<Measurement>? measurements,
  }) {
    return MeasurementState(
      isInitialized: isInitialized ?? this.isInitialized,
      attachments: attachments ?? this.attachments,
      services: services ?? this.services,
      measurements: measurements ?? this.measurements,
    );
  }
}

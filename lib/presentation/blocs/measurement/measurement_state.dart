import '../../../domain/entities/measurement.dart';
import '../../../domain/entities/service.dart';
import '../../../domain/entities/service_master.dart';

class MeasurementState {
  final List<String> attachments;
  final List<Service> services;
  final List<Measurement> measurements;
  final bool isInitialized;
  final ServiceMaster? selectedServiceMaster;
  final double totalAmount;

  MeasurementState({
    required this.attachments,
    required this.services,
    required this.measurements,
    required this.selectedServiceMaster,
    required this.totalAmount,
    this.isInitialized = false,
  });

  MeasurementState copyWith({
    bool? isInitialized,
    List<String>? attachments,
    List<Service>? services,
    List<Measurement>? measurements,
    ServiceMaster? selectedServiceMaster,
    double? totalAmount,
  }) {
    return MeasurementState(
      isInitialized: isInitialized ?? this.isInitialized,
      selectedServiceMaster: selectedServiceMaster ?? this.selectedServiceMaster,
      attachments: attachments ?? this.attachments,
      services: services ?? this.services,
      totalAmount: totalAmount ?? this.totalAmount,
      measurements: measurements ?? this.measurements,
    );
  }
}

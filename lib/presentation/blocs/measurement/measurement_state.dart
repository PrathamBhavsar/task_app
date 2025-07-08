import '../../../domain/entities/measurement.dart';
import '../../../domain/entities/service.dart';
import '../../../domain/entities/service_master.dart';

class MeasurementState {
  final List<Measurement> measurements;
  final List<Service> services;
  final List<String> attachments;
  final bool isInitialized;
  final ServiceMaster? selectedServiceMaster;
  final double totalAmount;
  final String unit;

  MeasurementState({
    required this.measurements,
    required this.services,
    required this.attachments,
    required this.isInitialized,
    required this.selectedServiceMaster,
    required this.totalAmount,
    required this.unit,
  });

  MeasurementState copyWith({
    List<Measurement>? measurements,
    List<Service>? services,
    List<String>? attachments,
    bool? isInitialized,
    ServiceMaster? selectedServiceMaster,
    double? totalAmount,
    String? unit,
  }) {
    return MeasurementState(
      measurements: measurements ?? this.measurements,
      services: services ?? this.services,
      attachments: attachments ?? this.attachments,
      isInitialized: isInitialized ?? this.isInitialized,
      selectedServiceMaster:
          selectedServiceMaster ?? this.selectedServiceMaster,
      totalAmount: totalAmount ?? this.totalAmount,
      unit: unit ?? this.unit,
    );
  }

  factory MeasurementState.initial() => MeasurementState(
    measurements: [],
    services: [],
    attachments: [],
    isInitialized: false,
    selectedServiceMaster: null,
    totalAmount: 0.0,
    unit: 'm',
  );
}

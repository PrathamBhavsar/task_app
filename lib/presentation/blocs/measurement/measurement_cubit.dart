import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/measurement.dart';
import '../../../domain/entities/service.dart';
import '../../../domain/entities/service_master.dart';
import '../../../domain/entities/task.dart';
import 'measurement_state.dart';

class MeasurementCubit extends Cubit<MeasurementState> {
  MeasurementCubit() : super(MeasurementState.initial());

  void initialize({
    required Task existingTask,
    required ServiceMaster serviceMaster,
    List<Service>? services,
    List<Measurement>? measurements,
    List<String>? attachments,
  }) {
    final serviceList = services ?? [];
    final measurementList = measurements ?? [];
    final attachmentList = attachments ?? [];

    measurementList.add(Measurement.empty(existingTask.taskId!));
    serviceList.add(Service.empty(existingTask.taskId!, serviceMaster));

    emit(state.copyWith(
      isInitialized: true,
      services: serviceList,
      measurements: measurementList,
      attachments: attachmentList,
      totalAmount: serviceMaster.rate,
    ));
  }

  void reset() {
    emit(state.copyWith(
      isInitialized: false,
      services: [],
      measurements: [],
      attachments: [],
    ));
  }

  void addMeasurement(Task task) {
    final updated = List<Measurement>.from(state.measurements)
      ..add(Measurement.empty(task.taskId!));
    emit(state.copyWith(measurements: updated));
  }

  void removeMeasurement(int index) {
    if (state.measurements.length <= 1) return;
    final updated = List<Measurement>.from(state.measurements)..removeAt(index);
    emit(state.copyWith(measurements: updated));
  }

  void updateMeasurementField({
    required int index,
    String? location,
    double? height,
    double? area,
    double? width,
    String? notes,
  }) {
    final updated = List<Measurement>.from(state.measurements);
    final old = updated[index];

    updated[index] = old.copyWith(
      location: location ?? old.location,
      height: height ?? old.height,
      area: area ?? old.area,
      width: width ?? old.width,
      notes: notes ?? old.notes,
    );

    emit(state.copyWith(measurements: updated));
  }

  void addService(Task task, ServiceMaster serviceMaster) {
    final updated = List<Service>.from(state.services)
      ..add(Service.empty(task.taskId!, serviceMaster));
    emit(state.copyWith(services: updated));
  }

  void removeService(int index) {
    if (state.services.length <= 1) return;
    final updated = List<Service>.from(state.services)..removeAt(index);
    emit(state.copyWith(services: updated));
  }

  void updateServiceField({
    required int index,
    double? rate,
    int? quantity,
  }) {
    final updated = List<Service>.from(state.services);
    final old = updated[index];

    final newRate = rate ?? old.rate;
    final newQty = quantity ?? old.quantity;

    updated[index] = old.copyWith(
      rate: newRate,
      quantity: newQty,
      amount: newRate * newQty,
    );

    final total = updated.fold<double>(
      0.0,
          (sum, s) => sum + s.rate * s.quantity,
    );

    emit(state.copyWith(services: updated, totalAmount: total));
  }

  void updateServiceMaster({
    required int index,
    required ServiceMaster serviceMaster,
  }) {
    final updated = List<Service>.from(state.services);
    final old = updated[index];

    updated[index] = old.copyWith(serviceMaster: serviceMaster);

    emit(state.copyWith(services: updated));
  }


  void addAttachment(String attachment) {
    final updated = List<String>.from(state.attachments)..add(attachment);
    emit(state.copyWith(attachments: updated));
  }

  void removeAttachment(int index) {
    final updated = List<String>.from(state.attachments)
      ..removeAt(index);
    emit(state.copyWith(attachments: updated));
  }

  void updateUnit(String unit) {
    emit(state.copyWith(unit: unit));
  }
}

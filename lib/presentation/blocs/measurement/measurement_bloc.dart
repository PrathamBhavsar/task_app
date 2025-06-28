import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/measurement.dart';
import '../../../domain/entities/service.dart';
import 'measurement_event.dart';
import 'measurement_state.dart';

class MeasurementBloc extends Bloc<MeasurementEvent, MeasurementState> {
  MeasurementBloc()
    : super(
        MeasurementState(
          attachments: [],
          measurements: [],
          services: [],
          isInitialized: false,
          selectedServiceMaster: null,
          totalAmount: 0.00,
        ),
      ) {
    on<InitializeMeasurement>(_onInit);
    on<ResetMeasurement>(_onReset);
    on<MeasurementAdded>(_onMeasurementAdded);
    on<MeasurementRemoved>(_onMeasurementRemoved);
    on<ServiceAdded>(_onServiceAdded);
    on<ServiceMasterUpdated>((event, emit) {
      final updated = List<Service>.from(state.services);
      final old = updated[event.index];

      updated[event.index] = old.copyWith(serviceMaster: event.serviceMaster);

      emit(state.copyWith(services: updated));
    });
    on<ServiceFieldUpdated>(_onServiceFieldUpdated);
    on<ServiceRemoved>(_onServiceRemoved);
    on<AttachmentAdded>(_onAttachmentAdded);
    on<AttachmentRemoved>(_onAttachmentRemoved);
  }

  void _onServiceFieldUpdated(
    ServiceFieldUpdated event,
    Emitter<MeasurementState> emit,
  ) {
    final updatedServices = List<Service>.from(state.services);
    final old = updatedServices[event.index];

    final newRate = event.rate ?? old.rate;
    final int newQty = event.quantity ?? old.quantity;

    updatedServices[event.index] = old.copyWith(
      rate: newRate,
      quantity: newQty,
      amount: newRate * newQty,
    );

    final newTotalAmount = updatedServices.fold<double>(
      0.0,
      (sum, service) => sum + (service.rate * service.quantity),
    );

    emit(
      state.copyWith(services: updatedServices, totalAmount: newTotalAmount),
    );
  }

  void _onMeasurementAdded(
    MeasurementAdded event,
    Emitter<MeasurementState> emit,
  ) {
    state.measurements.add(Measurement.empty(event.task.taskId!));
    return emit(state.copyWith(measurements: state.measurements));
  }

  void _onMeasurementRemoved(
    MeasurementRemoved event,
    Emitter<MeasurementState> emit,
  ) {
    if (state.measurements.length == 1) {
      return;
    }
    state.measurements.removeAt(event.index);
    return emit(state.copyWith(measurements: state.measurements));
  }

  void _onServiceAdded(ServiceAdded event, Emitter<MeasurementState> emit) {
    state.services.add(Service.empty(event.task.taskId!, event.serviceMaster));
    return emit(state.copyWith(services: state.services));
  }

  void _onServiceRemoved(ServiceRemoved event, Emitter<MeasurementState> emit) {
    if (state.services.length == 1) {
      return;
    }
    state.services.removeAt(event.index);
    return emit(state.copyWith(services: state.services));
  }

  void _onAttachmentAdded(
    AttachmentAdded event,
    Emitter<MeasurementState> emit,
  ) {
    state.attachments.add(event.attachment);
    return emit(state.copyWith(attachments: state.attachments));
  }

  void _onAttachmentRemoved(
    AttachmentRemoved event,
    Emitter<MeasurementState> emit,
  ) {
    state.attachments.removeAt(event.index);
    return emit(state.copyWith(attachments: state.attachments));
  }

  void _onInit(InitializeMeasurement event, Emitter<MeasurementState> emit) {
    final services = event.services ?? [];
    final measurements = event.measurements ?? [];
    final attachments = event.attachments ?? [];

    measurements.add(Measurement.empty(event.existingTask.taskId!));
    services.add(
      Service.empty(event.existingTask.taskId!, event.serviceMaster),
    );

    emit(
      state.copyWith(
        isInitialized: true,
        services: services,
        measurements: measurements,
        attachments: attachments,
        totalAmount: event.serviceMaster.rate
      ),
    );
  }

  void _onReset(ResetMeasurement event, Emitter<MeasurementState> emit) {
    emit(
      state.copyWith(
        isInitialized: false,
        services: [],
        measurements: [],
        attachments: [],
      ),
    );
  }
}

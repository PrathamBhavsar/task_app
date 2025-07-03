// quote_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/measurement.dart';
import '../../../../domain/entities/quote.dart';
import '../../../../domain/entities/quote_measurement.dart';
import '../../../../domain/entities/service.dart';
import '../../../../domain/entities/task.dart';
import 'quote_cubit_state.dart';

class QuoteCubit extends Cubit<QuoteCubitState> {
  QuoteCubit() : super(QuoteCubitState.initial());

  void initializeEmpty(
    Task task,
    List<Service> services,
    List<Measurement> measurements,
  ) {
    final quoteMeasurements =
        measurements
            .map((m) => QuoteMeasurement.empty(task.taskId!, m))
            .toList();

    emit(
      state.copyWith(
        task: task,
        services: services,
        measurements: measurements,
        quoteMeasurements: quoteMeasurements,
      ),
    );
  }

  void initialize(
    Task task,
    List<Service> services,
    List<Measurement> measurements,
    List<QuoteMeasurement> quoteMeasurements,
  ) {
    final double productSubtotal = quoteMeasurements
        .map((q) => q.totalPrice)
        .fold(0.0, (sum, price) => sum + price);

    final double serviceSubtotal = services
        .map((s) => s.amount)
        .fold(0.0, (sum, amount) => sum + amount);

    emit(
      state.copyWith(
        task: task,
        services: services,
        measurements: measurements,
        quoteMeasurements: quoteMeasurements,
        productSubtotal: productSubtotal,
        serviceSubtotal: serviceSubtotal,
      ),
    );
  }

  void updateQuoteMeasurement(
    int index, {
    double? rate,
    double? discount,
    int? quantity,
  }) {
    final updatedList = List<QuoteMeasurement>.from(state.quoteMeasurements);
    final old = updatedList[index];

    final double newRate =
        (rate != null) ? (old.rate + rate).clamp(0, double.infinity) : old.rate;
    final double newDiscount = discount ?? old.discount;
    final int newQty = quantity ?? old.quantity;
    final double newTotalPrice = (newRate * newQty) * (1 - newDiscount / 100);

    final double oldTotalPrice = old.totalPrice;
    final double priceDifference = newTotalPrice - oldTotalPrice;

    updatedList[index] = old.copyWith(
      rate: newRate,
      quantity: newQty,
      discount: newDiscount,
      totalPrice: newTotalPrice,
    );

    final oldQuote = state.quote;

    final updatedSubtotal = (oldQuote?.subtotal ?? 0) + priceDifference;
    final discountPercent = oldQuote?.discount ?? 0;
    final discountedSubtotal = updatedSubtotal * (1 - discountPercent / 100);
    final tax = discountedSubtotal * 0.07;
    final total = discountedSubtotal + tax;

    final updatedQuote = Quote(
      quoteId: state.quote!.quoteId,
      taskId: state.task!.taskId!,
      subtotal: updatedSubtotal,
      discount: discountPercent,
      tax: tax,
      total: total,
      createdAt: oldQuote?.createdAt ?? DateTime.now(),
    );

    emit(state.copyWith(quoteMeasurements: updatedList, quote: updatedQuote));
  }

  void updateOverallDiscount(double? discountPercent) {
    _recalculateQuote(state.quoteMeasurements, newDiscount: discountPercent);
  }

  void setQuote(Quote quote) {
    emit(state.copyWith(quote: quote));
  }

  void _recalculateQuote(
    List<QuoteMeasurement> measurements, {
    double? newDiscount,
  }) {
    final subtotal = measurements.fold(0.0, (sum, qm) => sum + qm.totalPrice);
    final discount = newDiscount ?? state.quote?.discount ?? 0.0;
    final discountedSubtotal = subtotal * (1 - discount / 100);
    final tax = discountedSubtotal * 0.07;
    final total = discountedSubtotal + tax;

    final newQuote = Quote(
      quoteId: state.quote!.quoteId,
      taskId: state.task!.taskId!,
      subtotal: discountedSubtotal,
      discount: discount,
      tax: tax,
      total: total,
      createdAt: state.quote?.createdAt ?? DateTime.now(),
    );

    emit(state.copyWith(quoteMeasurements: measurements, quote: newQuote));
  }
}

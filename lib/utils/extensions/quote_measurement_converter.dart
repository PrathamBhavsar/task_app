import '../../domain/entities/quote_measurement.dart';
import '../../domain/entities/update_quote_measurement.dart';

extension QuoteMeasurementMapper on QuoteMeasurement {
  UpdateQuoteMeasurement toUpdatePayload() {
    return UpdateQuoteMeasurement(
      measurementId: measurement.measurementId!,
      unitPrice: rate,
      quantity: quantity,
      discount: discount,
    );
  }
}

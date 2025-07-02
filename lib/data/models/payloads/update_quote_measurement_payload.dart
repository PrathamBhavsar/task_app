import 'package:json_annotation/json_annotation.dart';

part 'update_quote_measurement_payload.g.dart';

@JsonSerializable()
class UpdateQuoteMeasurementPayload {
  @JsonKey(name: 'id', includeToJson: false)
  final int quoteId;

  @JsonKey(name: 'task_id')
  final int taskId;

  final double subtotal;
  final double tax;
  final double total;

  final String? notes;

  const UpdateQuoteMeasurementPayload({
    required this.quoteId,
    required this.taskId,
    required this.subtotal,
    required this.tax,
    required this.total,

    this.notes,
  });

  Map<String, dynamic> toJson() => _$UpdateQuoteMeasurementPayloadToJson(this);
}

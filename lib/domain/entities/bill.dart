import 'package:json_annotation/json_annotation.dart';

import '../../utils/enums/bill_status.dart';

part 'bill.g.dart';

@JsonSerializable()
class Bill {

  @JsonKey(name: 'bill_id')
  final int? billId;

  @JsonKey(name: 'task_id')
  final int taskId;

  @JsonKey(name: 'due_date')
  final DateTime dueDate;

  final double total;
  final double subtotal;
  final double tax;

  @JsonKey(name: 'additional_notes')
  final String? notes;

 @BillStatusConverter()
  final BillStatus status;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  Bill({
    required this.taskId,
    required this.total,
    required this.subtotal,
    required this.tax,
    required this.status,
    required this.createdAt,
    required this.dueDate,
    this.notes,
    this.billId,
  });

  factory Bill.fromJson(Map<String, dynamic> json) => _$BillFromJson(json);

  Map<String, dynamic> toJson() => _$BillToJson(this);
}

class BillStatusConverter implements JsonConverter<BillStatus, String> {
  const BillStatusConverter();

  @override
  BillStatus fromJson(String json) => BillStatus.fromString(json);

  @override
  String toJson(BillStatus role) => role.status;
}

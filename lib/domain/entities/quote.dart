import 'package:json_annotation/json_annotation.dart';

part 'quote.g.dart';

@JsonSerializable()
class Quote {
  @JsonKey(name: 'quote_id')
  final int quoteId;

  @JsonKey(name: 'task_id')
  final int taskId;

  final double? discount;
  final double total;
  final double subtotal;
  final double tax;

  final String? notes;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  Quote({
    required this.total,
    required this.taskId,
    required this.subtotal,
    required this.tax,
    required this.createdAt,
    required this.quoteId, this.discount,
    this.notes,
  });

  factory Quote.fromJson(Map<String, dynamic> json) => _$QuoteFromJson(json);

  Map<String, dynamic> toJson() => _$QuoteToJson(this);
}

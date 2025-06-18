import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/bill.dart';

part 'get_bills_response.g.dart';

@JsonSerializable()
class GetBillsResponse {
  @JsonKey(name: 'bills')
  final List<Bill> bills;

  GetBillsResponse({required this.bills});

  factory GetBillsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetBillsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetBillsResponseToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/quote.dart';

part 'get_quote_response.g.dart';

@JsonSerializable()
class GetQuoteResponse {
  @JsonKey(name: 'quotes')
  final Quote quote;

  GetQuoteResponse({required this.quote});

  factory GetQuoteResponse.fromJson(Map<String, dynamic> json) =>
      _$GetQuoteResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetQuoteResponseToJson(this);
}

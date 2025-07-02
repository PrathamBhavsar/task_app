import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/quote.dart';

part 'update_quote_response.g.dart';

@JsonSerializable()
class UpdateQuoteResponse {
  @JsonKey(name: 'quote')
  final Quote quote;

  UpdateQuoteResponse({required this.quote});

  factory UpdateQuoteResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateQuoteResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateQuoteResponseToJson(this);
}

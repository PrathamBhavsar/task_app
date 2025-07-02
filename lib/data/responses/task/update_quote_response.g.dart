// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_quote_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateQuoteResponse _$UpdateQuoteResponseFromJson(Map<String, dynamic> json) =>
    UpdateQuoteResponse(
      quote: Quote.fromJson(json['quote'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpdateQuoteResponseToJson(
  UpdateQuoteResponse instance,
) => <String, dynamic>{'quote': instance.quote};

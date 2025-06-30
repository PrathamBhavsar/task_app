// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_quote_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetQuoteResponse _$GetQuoteResponseFromJson(Map<String, dynamic> json) =>
    GetQuoteResponse(
      quote: Quote.fromJson(json['quotes'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetQuoteResponseToJson(GetQuoteResponse instance) =>
    <String, dynamic>{'quotes': instance.quote};

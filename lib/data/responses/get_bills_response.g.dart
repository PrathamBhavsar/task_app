// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_bills_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBillsResponse _$GetBillsResponseFromJson(Map<String, dynamic> json) =>
    GetBillsResponse(
      bills:
          (json['bills'] as List<dynamic>)
              .map((e) => Bill.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$GetBillsResponseToJson(GetBillsResponse instance) =>
    <String, dynamic>{'bills': instance.bills};

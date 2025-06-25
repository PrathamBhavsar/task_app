// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_clients_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetClientsResponse _$GetClientsResponseFromJson(Map<String, dynamic> json) =>
    GetClientsResponse(
      clients:
          (json['clients'] as List<dynamic>)
              .map((e) => Client.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$GetClientsResponseToJson(GetClientsResponse instance) =>
    <String, dynamic>{'clients': instance.clients};

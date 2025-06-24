// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_designers_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetDesignersResponse _$GetDesignersResponseFromJson(
  Map<String, dynamic> json,
) => GetDesignersResponse(
  designers:
      (json['designers'] as List<dynamic>)
          .map((e) => Designer.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$GetDesignersResponseToJson(
  GetDesignersResponse instance,
) => <String, dynamic>{'designers': instance.designers};

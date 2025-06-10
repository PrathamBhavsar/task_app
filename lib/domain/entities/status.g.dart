// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Status _$StatusFromJson(Map<String, dynamic> json) => Status(
  statusId: (json['status_id'] as num?)?.toInt(),
  name: json['name'] as String,
  slug: json['slug'] as String,
  color: json['color'] as String,
);

Map<String, dynamic> _$StatusToJson(Status instance) => <String, dynamic>{
  'status_id': instance.statusId,
  'name': instance.name,
  'slug': instance.slug,
  'color': instance.color,
};

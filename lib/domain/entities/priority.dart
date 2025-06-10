import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'priority.g.dart';

@JsonSerializable()
class Priority extends Equatable {
  @JsonKey(name: 'priority_id')
  final int? priorityId;

  final String name;
  final String color;

  const Priority({
    required this.priorityId,
    required this.name,
    required this.color,
  });

  factory Priority.fromJson(Map<String, dynamic> json) =>
      _$PriorityFromJson(json);

  Map<String, dynamic> toJson() => _$PriorityToJson(this);

  @override
  List<Object?> get props => [priorityId, name, color];
}

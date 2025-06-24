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

  static List<Priority> get list => [
    Priority(priorityId: 1, name: "Medium", color: "#FFA500"),
    Priority(priorityId: 2, name: "Low", color: "#008000"),
    Priority(priorityId: 3, name: "High", color: "#FF0000"),
  ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Priority &&
          runtimeType == other.runtimeType &&
          priorityId == other.priorityId;

  @override
  int get hashCode => priorityId.hashCode;
}

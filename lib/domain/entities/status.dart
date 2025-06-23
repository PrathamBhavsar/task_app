import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'status.g.dart';

@JsonSerializable()
class Status extends Equatable {
  @JsonKey(name: 'status_id')
  final int? statusId;
  final String name;
  final String slug;
  final String color;

  const Status({
    required this.statusId,
    required this.name,
    required this.slug,
    required this.color,
  });

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);

  Map<String, dynamic> toJson() => _$StatusToJson(this);

  @override
  List<Object?> get props => [statusId, name, slug, color];

  static List<Status> get list => [
    Status(statusId: 1, name: "Created", slug: "created", color: "#FFA500"),
    Status(statusId: 2, name: "Pending", slug: "pending", color: "#FFA500"),
    Status(statusId: 3, name: "Approved", slug: "approved", color: "#008000"),
    Status(statusId: 4, name: "Rejected", slug: "rejected", color: "#FF0000"),
  ];
}

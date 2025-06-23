import 'package:json_annotation/json_annotation.dart';

import '../../utils/converters/status_converter.dart';
import 'status.dart';
import 'user.dart';

part 'timeline.g.dart';

@JsonSerializable()
class Timeline {
  @JsonKey(name: 'timeline_id')
  final int? timelineId;

  @JsonKey(name: 'task_id')
  final int taskId;

  final User user;

  @StatusConverter()
  final Status status;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  Timeline({
    required this.taskId,
    required this.user,
    required this.status,
    required this.createdAt,
    this.timelineId,
  });

  factory Timeline.fromJson(Map<String, dynamic> json) => _$TimelineFromJson(json);

  Map<String, dynamic> toJson() => _$TimelineToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/task.dart';

part 'get_tasks_response.g.dart';

@JsonSerializable()
class GetTasksResponse {
  @JsonKey(name: 'tasks')
  final List<Task> tasks;

  GetTasksResponse({required this.tasks});

  factory GetTasksResponse.fromJson(Map<String, dynamic> json) =>
      _$GetTasksResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetTasksResponseToJson(this);
}

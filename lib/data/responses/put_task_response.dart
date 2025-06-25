import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/task.dart';
part 'put_task_response.g.dart';

@JsonSerializable()
class PutTaskResponse {
  @JsonKey(name: 'task')
  final Task task;

  PutTaskResponse({required this.task});

  factory PutTaskResponse.fromJson(Map<String, dynamic> json) =>
      _$PutTaskResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PutTaskResponseToJson(this);
}

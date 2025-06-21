import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/timeline.dart';

part 'get_timelines_response.g.dart';

@JsonSerializable()
class GetTimelinesResponse {
  @JsonKey(name: 'timelines')
  final List<Timeline> timelines;

  GetTimelinesResponse({required this.timelines});

  factory GetTimelinesResponse.fromJson(Map<String, dynamic> json) =>
      _$GetTimelinesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetTimelinesResponseToJson(this);
}

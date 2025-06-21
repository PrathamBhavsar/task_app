import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/status.dart';

part 'get_statuses_response.g.dart';

@JsonSerializable()
class GetStatusesResponse {
  @JsonKey(name: 'statuss')
  final List<Status> statuses;

  GetStatusesResponse({required this.statuses});

  factory GetStatusesResponse.fromJson(Map<String, dynamic> json) =>
      _$GetStatusesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetStatusesResponseToJson(this);
}

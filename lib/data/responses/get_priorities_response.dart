import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/priority.dart';

part 'get_priorities_response.g.dart';

@JsonSerializable()
class GetPrioritiesResponse {
  @JsonKey(name: 'prioritys')
  final List<Priority> priorities;

  GetPrioritiesResponse({required this.priorities});

  factory GetPrioritiesResponse.fromJson(Map<String, dynamic> json) =>
      _$GetPrioritiesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetPrioritiesResponseToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/designer.dart';

part 'get_designers_response.g.dart';

@JsonSerializable()
class GetDesignersResponse {
  @JsonKey(name: 'designers')
  final List<Designer> designers;

  GetDesignersResponse({required this.designers});

  factory GetDesignersResponse.fromJson(Map<String, dynamic> json) =>
      _$GetDesignersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetDesignersResponseToJson(this);
}

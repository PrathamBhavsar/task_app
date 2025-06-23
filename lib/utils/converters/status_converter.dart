import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/status.dart';
import '../enums/status_type.dart';

class StatusConverter implements JsonConverter<Status, String> {
  const StatusConverter();

  @override
  Status fromJson(String json) => StatusTypeX.fromString(json);

  @override
  String toJson(Status status) => status.name;
}

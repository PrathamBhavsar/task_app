import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/priority.dart';
import '../enums/priority_type.dart';

class PriorityConverter implements JsonConverter<Priority, String> {
  const PriorityConverter();

  @override
  Priority fromJson(String json) => PriorityTypeX.fromString(json);

  @override
  String toJson(Priority priority) => priority.name;
}

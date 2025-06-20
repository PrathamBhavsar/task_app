import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum TaskStatus {
  @JsonValue('Pending')
  pending,

  @JsonValue('Approved')
  approved,

  @JsonValue('Rejected')
  rejected;

  String get status {
    switch (this) {
      case TaskStatus.pending:
        return 'Pending';
      case TaskStatus.approved:
        return 'Approved';
      case TaskStatus.rejected:
        return 'Rejected';
    }
  }

  static TaskStatus fromString(String value) {
    return TaskStatus.values.firstWhere(
          (e) => e.status == value,
      orElse: () => throw ArgumentError('Invalid task status: $value'),
    );
  }
}

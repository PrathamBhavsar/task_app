import 'package:json_annotation/json_annotation.dart';

@JsonEnum()
enum BillStatus {
  @JsonValue('Pending')
  pending,

  @JsonValue('Approved')
  approved,

  @JsonValue('Rejected')
  rejected;

  String get status {
    switch (this) {
      case BillStatus.pending:
        return 'Pending';
      case BillStatus.approved:
        return 'Approved';
      case BillStatus.rejected:
        return 'Rejected';
    }
  }

  static BillStatus fromString(String value) {
    return BillStatus.values.firstWhere(
          (e) => e.status == value,
      orElse: () => throw ArgumentError('Invalid bill status: $value'),
    );
  }
}

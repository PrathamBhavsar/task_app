import '../../domain/entities/status.dart';
import '../enums/status_type.dart';

extension StatusX on Status {
  StatusType? toStatusType() {
    try {
      return StatusType.values.firstWhere((type) => type.status.slug == slug);
    } catch (_) {
      return null;
    }
  }
}

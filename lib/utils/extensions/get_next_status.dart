import '../../domain/entities/status.dart';
import '../enums/status_type.dart' show StatusType, StatusTypeX;

extension StatusTypeExtension on StatusType {
  static StatusType? nextFromId(int currentId) {
    final list = StatusType.values;
    final index = list.indexWhere((e) => e.status.statusId == currentId);
    if (index == -1 || index + 1 >= list.length) {
      return null;
    }
    return list[index + 1];
  }

  static StatusType? fromId(int id) {
    return StatusType.values.firstWhere(
      (e) => e.status.statusId == id,
      orElse: () => StatusType.created,
    );
  }

  StatusType? get next {
    final index = StatusType.values.indexOf(this);
    if (index == -1 || index + 1 >= StatusType.values.length) {
      return null;
    }
    return StatusType.values[index + 1];
  }
}

extension StatusExtension on Status {
  Status? get next {
    final nextId = statusId! + 1;
    return Status.list.firstWhere(
          (s) => s.statusId == nextId,
    );
  }
}

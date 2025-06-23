import '../../domain/entities/priority.dart';

enum PriorityType { pending, approved, rejected }

extension PriorityTypeX on PriorityType {
  static Priority fromString(String priorityString) {
    switch (priorityString) {
      case 'Medium':
        return Priority(priorityId: 1, name: 'Medium', color: '#FFA500');
      case 'Low':
        return Priority(priorityId: 2, name: 'Low', color: '#008000');
      case 'High':
        return Priority(priorityId: 3, name: 'High', color: '#FF0000');
      default:
        throw ArgumentError('Unknown priority: $priorityString');
    }
  }
}

import '../../domain/entities/status.dart';

enum StatusType { pending, approved, rejected }

extension StatusTypeX on StatusType {
  static Status fromString(String statusString) {
    switch (statusString) {
      case 'Created':
        return Status(
          statusId: 1,
          name: 'Pending',
          slug: 'pending',
          color: '#FFA500',
        );
      case 'Pending':
        return Status(
          statusId: 2,
          name: 'Pending',
          slug: 'pending',
          color: '#FFA500',
        );
      case 'Approved':
        return Status(
          statusId: 3,
          name: 'Approved',
          slug: 'approved',
          color: '#008000',
        );
      case 'Rejected':
        return Status(
          statusId: 4,
          name: 'Rejected',
          slug: 'rejected',
          color: '#FF0000',
        );
      default:
        throw ArgumentError('Unknown status: $statusString');
    }
  }
}

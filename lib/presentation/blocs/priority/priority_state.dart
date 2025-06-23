import '../../../core/error/failure.dart';
import '../../../domain/entities/priority.dart';

abstract class PriorityState {}
class PriorityInitial extends PriorityState {}
class PriorityLoadInProgress extends PriorityState {}
class PriorityLoadSuccess extends PriorityState {
  final List<Priority> statuses;
  PriorityLoadSuccess(this.statuses);
}
class PriorityLoadFailure extends PriorityState {
  final Failure error;
  PriorityLoadFailure(this.error);
}

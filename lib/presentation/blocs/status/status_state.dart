import '../../../core/error/failure.dart';
import '../../../domain/entities/status.dart';

abstract class StatusState {}
class StatusInitial extends StatusState {}
class StatusLoadInProgress extends StatusState {}
class StatusLoadSuccess extends StatusState {
  final List<Status> statuses;
  StatusLoadSuccess(this.statuses);
}
class StatusLoadFailure extends StatusState {
  final Failure error;
  StatusLoadFailure(this.error);
}

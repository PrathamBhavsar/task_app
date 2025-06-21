import '../../../core/error/failure.dart';
import '../../../domain/entities/timeline.dart';

abstract class TimelineState {}
class TimelineInitial extends TimelineState {}
class TimelineLoadInProgress extends TimelineState {}
class TimelineLoadSuccess extends TimelineState {
  final List<Timeline> timelines;
  TimelineLoadSuccess(this.timelines);
}
class TimelineLoadFailure extends TimelineState {
  final Failure error;
  TimelineLoadFailure(this.error);
}

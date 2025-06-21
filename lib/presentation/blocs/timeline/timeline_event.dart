abstract class TimelineEvent {}
class FetchTimelinesRequested extends TimelineEvent {
  final int taskId;

  FetchTimelinesRequested(this.taskId);
}

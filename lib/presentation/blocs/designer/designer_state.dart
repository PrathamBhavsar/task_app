import '../../../core/error/failure.dart';
import '../../../domain/entities/designer.dart';

abstract class DesignerState {}
class DesignerInitial extends DesignerState {}
class DesignerLoadInProgress extends DesignerState {}
class DesignerLoadSuccess extends DesignerState {
  final List<Designer> designers;
  DesignerLoadSuccess(this.designers);
}
class DesignerLoadFailure extends DesignerState {
  final Failure error;
  DesignerLoadFailure(this.error);
}

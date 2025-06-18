import '../../../core/error/failure.dart';
import '../../../domain/entities/bill.dart';

abstract class BillState {}
class BillInitial extends BillState {}
class BillLoadInProgress extends BillState {}
class BillLoadSuccess extends BillState {
  final List<Bill> bills;
  BillLoadSuccess(this.bills);
}
class BillLoadFailure extends BillState {
  final Failure error;
  BillLoadFailure(this.error);
}

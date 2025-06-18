
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/bill_usecase.dart';
import 'bill_event.dart';
import 'bill_state.dart';


class BillBloc extends Bloc<BillEvent, BillState> {
  final GetAllBillsUseCase _getAllBillsUseCase;

  BillBloc(this._getAllBillsUseCase) : super(BillInitial()) {
    on<FetchBillsRequested>(_onFetchBills);
  }

  Future<void> _onFetchBills(
      FetchBillsRequested event,
      Emitter<BillState> emit,
      ) async {
    emit(BillLoadInProgress());
    final result = await _getAllBillsUseCase();
    result.fold(
          (failure) => emit(BillLoadFailure(failure)),
          (bills) => emit(BillLoadSuccess(bills)),
    );
  }
}

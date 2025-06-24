
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/designer_usecase.dart';
import 'designer_event.dart';
import 'designer_state.dart';


class DesignerBloc extends Bloc<DesignerEvent, DesignerState> {
  final GetAllDesignersUseCase _getAllDesignersUseCase;

  DesignerBloc(this._getAllDesignersUseCase) : super(DesignerInitial()) {
    on<FetchDesignersRequested>(_onFetchDesigners);
  }

  Future<void> _onFetchDesigners(
      FetchDesignersRequested event,
      Emitter<DesignerState> emit,
      ) async {
    emit(DesignerLoadInProgress());
    final result = await _getAllDesignersUseCase();
    result.fold(
          (failure) => emit(DesignerLoadFailure(failure)),
          (designers) => emit(DesignerLoadSuccess(designers)),
    );
  }
}

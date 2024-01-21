import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';

part 'status_grid_state.dart';

//enum GridViewStatus { singleView, multiView }

class StatusGridCubit extends Cubit<StatusGridState> {
  StatusGridCubit() : super(const StatusGridViewState(GridStatus.multiView));

  void toggleStatusGrid(GridStatus currentStatus) {
    if (state is StatusGridViewState) {
      final currentState = state as StatusGridViewState;

      emit(
        currentState.copyWith(
            currentStatus: currentState.currentStatus == GridStatus.singleView
                ? GridStatus.multiView
                : GridStatus.singleView),
      );
    }
  }
}

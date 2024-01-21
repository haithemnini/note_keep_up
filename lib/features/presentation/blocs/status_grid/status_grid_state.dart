part of 'status_grid_cubit.dart';

sealed class StatusGridState extends Equatable {
  const StatusGridState();

  @override
  List<Object> get props => [];
}

final class StatusGridInitial extends StatusGridState {}

final class StatusGridViewState extends StatusGridState {
  final GridStatus currentStatus;

  const StatusGridViewState(this.currentStatus);

  StatusGridViewState copyWith({GridStatus? currentStatus}) {
    return StatusGridViewState(currentStatus ?? this.currentStatus);
  }

  @override
  List<Object> get props => [currentStatus];
}

part of 'status_icons_cubit.dart';

sealed class StatusIconsState extends Equatable {
  const StatusIconsState();

  @override
  List<Object> get props => [];
}

final class StatusIconsInitial extends StatusIconsState {}

final class ToggleIconsStatusState extends StatusIconsState {
  final Note currentNote;
  final StatusNote currentNoteStatus;
  final ArchiveStatus currentArchiveStatus;

  const ToggleIconsStatusState({
    required this.currentNote,
    required this.currentNoteStatus,
    required this.currentArchiveStatus,
  });

  @override
  List<Object> get props =>
      [currentArchiveStatus, currentNoteStatus, currentNote];
}

final class ReadOnlyState extends StatusIconsState {
  final Note currentNote;

  const ReadOnlyState(this.currentNote);

  @override
  List<Object> get props => [currentNote];
}

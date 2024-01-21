part of 'note_bloc.dart';

sealed class NoteState extends Equatable {
  const NoteState();

  @override
  List<Object> get props => [];
}

final class LoadingState extends NoteState {
  final DrawerSectionView drawerSectionView;

  const LoadingState(
    this.drawerSectionView,
  );

  @override
  List<Object> get props => [drawerSectionView];
}

final class NotesViewState extends NoteState {
  final List<Note> otherNotes;
  final List<Note> pinnedNotes;

  const NotesViewState(
    this.otherNotes,
    this.pinnedNotes,
  );
  @override
  List<Object> get props => [pinnedNotes, otherNotes];
}

final class ModifedColorNoteState extends NoteState {
  final int colorIndex;

  const ModifedColorNoteState(
    this.colorIndex,
  );
  @override
  List<Object> get props => [colorIndex];
}

final class GetNoteByIdState extends NoteState {
  final Note note;

  const GetNoteByIdState(this.note);

  @override
  List<Object> get props => [note];
}

//===>  MessageState

final class MessageState extends NoteState {
  final String message;

  const MessageState(this.message);
  @override
  List<Object> get props => [message];
}

final class ErrorState extends MessageState {
  final DrawerSectionView drawerSectionView;
  const ErrorState(
    super.message,
    this.drawerSectionView,
  );
  @override
  List<Object> get props => [message, drawerSectionView];
}

final class SuccessState extends MessageState {
  const SuccessState(super.message);
}

final class ToggleSuccessState extends MessageState {
  const ToggleSuccessState(super.message);
}

final class EmptyInputsState extends MessageState {
  const EmptyInputsState(super.message);
}

//===>  MessageState
final class GoPopNoteState extends NoteState {}

final class EmptyNoteState extends NoteState {
  final DrawerSectionView drawerSectionView;

  const EmptyNoteState(
    this.drawerSectionView,
  );

  @override
  List<Object> get props => [drawerSectionView];
}

final class AvailableNoteState extends NoteState {
  final Note note;

  const AvailableNoteState(
    this.note,
  );

  @override
  List<Object> get props => [note];
}

final class ReadOnlyNoteState extends NoteState {
  final bool readOnly;

  const ReadOnlyNoteState(
    this.readOnly,
  );

  @override
  List<Object> get props => [readOnly];
}

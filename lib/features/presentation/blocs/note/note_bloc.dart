import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../domain/entities/note.dart';
import '../../../domain/usecases/add_note.dart';
import '../../../domain/usecases/detele_note.dart';
import '../../../domain/usecases/get_note_by_id.dart';
import '../../../domain/usecases/get_notes.dart';
import '../../../domain/usecases/update_note.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final GetNotesUsecase getNotes;
  final GetNoteByIdUsecase getNoteById;
  final AddNoteUsecase addNote;
  final UpdateNoteUsecase updateNote;
  final DeleteNoteUsecase deleteNote;
  NoteBloc({
    required this.getNotes,
    required this.getNoteById,
    required this.addNote,
    required this.updateNote,
    required this.deleteNote,
  }) : super(LoadingState(DrawerSelect.drawerSection)) {
    on<LoadNotes>(_onLoadNotes);
    on<AddNote>(_onAddNote);
    on<GetNoteById>(_onGetById);
    on<UpdateNote>(_onUpdateNote);
    on<DeleteNote>(_onDeleteNote);
    on<RefreshNotes>(_onRefreshNotes);
    on<ModifColorNote>(_onModifColorNote);
    on<EmptyInputs>(_onEmptyInputs);
    //Action Event
    on<MoveNote>(_onMoveNote);
    on<UndoMoveNote>(_onUndoMoveNote);
    on<PopNoteAction>(_onPopNoteAction);
    //====
  }
  Note? oldNote;
  bool _isNewNote = false;

  int _colorIndex = 0;
  int get currentColor => _colorIndex;

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  GlobalKey<ScaffoldState> get appScaffoldState => _key;

  _onLoadNotes(LoadNotes event, Emitter<NoteState> emit) async {
    final failureOrLoaded = await getNotes();
    emit(LoadingState(event.drawerSectionView));
    await Future.delayed(const Duration(seconds: 2));
    emit(_mapLoadNotesState(failureOrLoaded, event.drawerSectionView));
  }

  _onRefreshNotes(RefreshNotes event, Emitter<NoteState> emit) async {
    final failureOrLoaded = await getNotes();
    emit(LoadingState(event.drawerSectionView));
    emit(_mapLoadNotesState(failureOrLoaded, event.drawerSectionView));
  }

  _onAddNote(AddNote event, Emitter<NoteState> emit) async {
    final Either<Failure, Unit> failureOrSuccess = await addNote(event.note);
    emit(
      failureOrSuccess.fold(
        (failure) => (ErrorState(
          _mapFailureMsg(failure),
          DrawerSelect.drawerSection,
        )),
        (_) => (const SuccessState(ADD_SUCCESS_MSG)),
      ),
    );
  }

  _onEmptyInputs(EmptyInputs event, Emitter<NoteState> emit) {
    emit(const EmptyInputsState(EMPTY_TEXT_MSG));
  }

  _onGetById(GetNoteById event, Emitter<NoteState> emit) async {
    final failureOrSuccess = await getNoteById(event.noteId);
    emit(
      failureOrSuccess.fold(
        (_) {
          _isNewNote = true;
          return GetNoteByIdState(Note.empty());
        },
        (note) {
          _isNewNote = false;
          return GetNoteByIdState(note);
        },
      ),
    );
  }

  _onUpdateNote(UpdateNote event, Emitter<NoteState> emit) async {
    final Either<Failure, Unit> failureOrSuccess = await updateNote(event.note);
    emit(
      failureOrSuccess.fold(
        (failure) => (ErrorState(
          _mapFailureMsg(failure),
          DrawerSelect.drawerSection,
        )),
        (_) => (const SuccessState(UPDATE_SUCCESS_MSG)),
      ),
    );
  }

  _onDeleteNote(DeleteNote event, Emitter<NoteState> emit) async {
    final failureOrSuccess = await deleteNote(event.noteId);
    emit(
      failureOrSuccess.fold(
        (failure) => (ErrorState(
          _mapFailureMsg(failure),
          DrawerSelect.drawerSection,
        )),
        (_) => (const SuccessState(DELETE_SUCCESS_MSG)),
      ),
    );
    emit(GoPopNoteState());
  }

  _onModifColorNote(ModifColorNote event, Emitter<NoteState> emit) {
    _colorIndex = event.colorIndex;
    emit(ModifedColorNoteState(_colorIndex));
  }

  _onPopNoteAction(PopNoteAction event, Emitter<NoteState> emit) async {
    final Note currentNote = event.currentNote;
    final Note originNote = event.originNote;

    // Check if the note is dirty (requires update)
    final bool isDirty = currentNote != originNote;

    // Set the modified time
    final Note updatedNote = currentNote.copyWith(modifiedTime: DateTime.now());

    // Check if the note is empty
    final bool isNoteEmpty =
        currentNote.title.isEmpty && currentNote.content.isEmpty;

    if (_isNewNote && isNoteEmpty) {
      // New note is empty, emit an empty input state
      add(EmptyInputs());
    } else if (_isNewNote || (!_isNewNote && isDirty)) {
      // Existing note is dirty, update the note
      _isNewNote ? add(AddNote(currentNote)) : add(UpdateNote(updatedNote));
    }

    // Notify to close the details page
    emit(GoPopNoteState());
  }

  _onMoveNote(MoveNote event, Emitter<NoteState> emit) async {
    final bool existsNote = event.note != null;
    final StatusNote newStatus = event.newStatus;

    if (!existsNote) {
      emit(const EmptyInputsState(EMPTY_TEXT_MSG));
      emit(GoPopNoteState());
      return;
    }

    oldNote = event.note!;

    Future<NoteState> updateNoteAndEmit({
      required StatusNote statusNote,
      required NoteState successState,
    }) async {
      final updatedNote = event.note!.copyWith(
        statusNote: statusNote,
        modifiedTime: DateTime.now(),
      );

      final failureOrSuccess = await updateNote(updatedNote);

      return failureOrSuccess.fold(
        (failure) => ErrorState(
          _mapFailureMsg(failure),
          DrawerSelect.drawerSection,
        ),
        (_) => successState,
      );
    }

    Future<NoteState>? newState;

    switch (newStatus) {
      case StatusNote.archived:
        newState = updateNoteAndEmit(
          statusNote: newStatus,
          successState: ToggleSuccessState(
            event.note!.stateNote == StatusNote.pinned
                ? NOTE_ARCHIVE_WITH_UNPINNED_MSG
                : NOTE_ARCHIVE_MSG,
          ),
        );
        break;
      case StatusNote.undefined:
        newState = updateNoteAndEmit(
          statusNote: newStatus,
          successState: const ToggleSuccessState(NOTE_UNARCHIVED_MSG),
        );
        break;
      case StatusNote.trash:
        newState = updateNoteAndEmit(
          statusNote: newStatus,
          successState: const ToggleSuccessState(MOVE_NOTE_TRASH_MSG),
        );
        break;
      case StatusNote.pinned:
        break;
    }
    emit(await newState!);
    emit(GoPopNoteState());
  }

  _onUndoMoveNote(UndoMoveNote event, Emitter<NoteState> emit) async {
    await updateNote(oldNote!);
    emit(GoPopNoteState());
  }

  //===================> <======================//
  //=> // Map Return : Pin Notes || Not Pin Notes(Other Notes) || Empty Notes
  NoteState _mapLoadNotesState(
    Either<Failure, List<Note>> either,
    DrawerSectionView drawerSectionView,
  ) {
    return either.fold(
      (failure) {
        return (ErrorState(
          _mapFailureMsg(failure),
          DrawerSelect.drawerSection,
        ));
      },
      (notes) {
        notes.sort((a, b) => b.modifiedTime.compareTo(a.modifiedTime));
        List<Note> filterNotesByState(List<Note> notes, StatusNote state) {
          return notes.where((note) => note.stateNote == state).toList();
        }

        final pinnedNotes = filterNotesByState(notes, StatusNote.pinned);
        final undefinedNotes = filterNotesByState(notes, StatusNote.undefined);
        final archiveNotes = filterNotesByState(notes, StatusNote.archived);
        final trashNotes = filterNotesByState(notes, StatusNote.trash);

        bool hasPinnedNotes = pinnedNotes.isNotEmpty;
        bool hasUndefinedNotes = undefinedNotes.isNotEmpty;
        bool hasArchiveNotes = archiveNotes.isNotEmpty;
        bool hasTrashNotes = trashNotes.isNotEmpty;

        switch (drawerSectionView) {
          case DrawerSectionView.home:
            if (notes.isEmpty || (!hasUndefinedNotes && !hasPinnedNotes)) {
              return EmptyNoteState(drawerSectionView);
            }
            return hasPinnedNotes
                ? NotesViewState(undefinedNotes, pinnedNotes)
                : NotesViewState(undefinedNotes, const []);

          case DrawerSectionView.archive:
            if (notes.isEmpty || (!hasArchiveNotes)) {
              return EmptyNoteState(drawerSectionView);
            }
            return NotesViewState(archiveNotes, const []);

          case DrawerSectionView.trash:
            if (notes.isEmpty || (!hasTrashNotes)) {
              return EmptyNoteState(drawerSectionView);
            }
            return NotesViewState(trashNotes, const []);
        }
      },
    );
  }

  //=> // Map Return : Failure Msg
  String _mapFailureMsg(Failure failure) {
    switch (failure.runtimeType) {
      case DatabaseFailure:
        return DATABASE_FAILURE_MSG;
      case NoDataFailure:
        return NO_DATA_FAILURE_MSG;
      default:
        return 'Unexpected Error , Please try again later . ';
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:note_app/features/domain/entities/note.dart';

import '../../../../core/core.dart';
import '../../../domain/usecases/get_notes.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final GetNotesUsecase getNotes;
  SearchCubit({
    required this.getNotes,
  }) : super(SearchInitial());

  void searchFetch(String query) async {
    emit(SearchLoading());

    final failureOrLoaded = await getNotes();

    failureOrLoaded.fold(
      (failure) => emit(SearchError(_mapFailureMsg(failure))),
      (listOfNotes) {
        final List<Note> filteredList = listOfNotes.where((note) {
          final bool isInTrash = note.stateNote == StatusNote.trash;
          final bool containsQuery =
              note.title.toLowerCase().contains(query.toLowerCase()) ||
                  note.content.toLowerCase().contains(query.toLowerCase());

          // قم بتجاوز البحث في حالة trash
          return isInTrash ? false : containsQuery;
        }).toList();

        final bool isEmptylistOfNotes = filteredList.isEmpty;

        isEmptylistOfNotes
            ? emit(const EmptySearch('No matching notes'))
            : emit(SearchLoaded(filteredList));
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

part of 'search_cubit.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchError extends SearchState {
  final String meassge;

  const SearchError(this.meassge);
}

final class SearchLoaded extends SearchState {
  final List<Note> note;

  const SearchLoaded(this.note);

  @override
  List<Object> get props => [note];
}

final class EmptySearch extends SearchState {
  final String meassge;

  const EmptySearch(this.meassge);

  @override
  List<Object> get props => [meassge];
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/domain/entities/note.dart';
import '../../../features/presentation/blocs/blocs.dart';
import '../../../features/presentation/pages/home/widgets/widgets.dart';
import '../../util/util.dart';

class NotesSearching extends SearchDelegate {
  @override
  String? get searchFieldLabel => 'Search your notes';

  @override
  TextStyle? get searchFieldStyle => const TextStyle().copyWith(fontSize: 18.0);

  @override
  List<Widget>? buildActions(BuildContext context) => query.isNotEmpty
      ? [IconButton(onPressed: () => query = '', icon: const Icon(Icons.close))]
      : [];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.navigate_before),
      );

  @override
  Widget buildResults(BuildContext context) => _buildSearchResults(context);

  @override
  Widget buildSuggestions(BuildContext context) => _buildSearchResults(context);

  Widget _buildSearchResults(BuildContext context) {
    if (query.isEmpty) return const SizedBox.shrink();

    context.read<SearchCubit>().searchFetch(query);

    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        if (state is SearchLoading) {
          return _buildLoadingIndicator();
        } else if (state is SearchLoaded) {
          return _buildSearchLoaded(state.note);
        } else if (state is EmptySearch) {
          return _buildEmptySearch(state.meassge);
        } else if (state is SearchError) {
          return _buildSearchError(state.meassge);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return const CustomScrollView(
      slivers: [
        SliverFillRemaining(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchLoaded(List<Note> notes) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: SizedBox(height: 20)),
        GridNotes(notes: notes, isShowDismisse: false),
      ],
    );
  }

  Widget _buildEmptySearch(String meassge) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [AppIcons.emptySearch, Text(meassge)],
          ),
        ),
      ],
    );
  }

  Widget _buildSearchError(String meassge) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [AppIcons.error, Text(meassge)],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/core/core.dart';
import 'package:note_app/app/di/get_it.dart' as di;

import '../../features/presentation/blocs/blocs.dart';

class AppProviders extends StatelessWidget {
  final Widget child;

  const AppProviders({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.gI<NoteBloc>()
            ..add(const LoadNotes(drawerSectionView: DrawerSectionView.home)),
        ),
        BlocProvider(create: (_) => di.gI<StatusGridCubit>()),
        BlocProvider(create: (_) => di.gI<StatusIconsCubit>()),
        BlocProvider(create: (_) => di.gI<ProfileCubit>()),
        BlocProvider(create: (_) => di.gI<SearchCubit>()),
        BlocProvider(create: (_) => di.gI<ThemeCubit>()..getCurrentThemeMode()),
      ],
      child: child,
    );
  }
}

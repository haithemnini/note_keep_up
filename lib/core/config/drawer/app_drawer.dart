import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/presentation/blocs/blocs.dart';
import '../../core.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        return Drawer(
          //width: 300,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                _buildTextLOGO(context),
                const MenuDrawerItem(DrawerViews.home),
                const Divider(),
                const MenuDrawerItem(DrawerViews.archive),
                const MenuDrawerItem(DrawerViews.trash),
                const MenuDrawerItem(DrawerViews.setting),
                const Divider(),
              ],
            ),
          ),
        );
      },
    );
  }

  _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
    );
  }

  _buildTextLOGO(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Text.rich(
        style: context.textTheme.headlineSmall,
        TextSpan(
          children: [
            TextSpan(
              text: 'KeepUp Note',
              style: const TextStyle().copyWith(fontWeight: FontWeight.bold),
            ),
            const TextSpan(text: ' '),
            const TextSpan(text: 'Note'),
          ],
        ),
      ),
    );
  }
//
}

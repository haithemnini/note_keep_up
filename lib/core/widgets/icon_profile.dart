import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/presentation/blocs/blocs.dart';
import '../core.dart';

class IconProfile extends StatelessWidget {
  const IconProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: (previous, current) => current is ProfileChanged,
      builder: (context, state) {
        final String currentProfileImg = (state as ProfileChanged).profileImg;
        return IconButton(
          padding: const EdgeInsets.all(2),
          icon: CircleAvatar(
            radius: 15,
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage(currentProfileImg),
          ),
          onPressed: () => _onShowDialog(context),
        );
      },
    );
  }

  _onShowDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        AlertDialog alertProfiles = const AlertDialog(
          contentPadding: EdgeInsets.all(5),
          scrollable: true,
          content: LinearProfiles(),
        );

        return alertProfiles;
      },
    );
  }
}

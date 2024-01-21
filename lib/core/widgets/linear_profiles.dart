import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/presentation/blocs/blocs.dart';
import '../core.dart';

class LinearProfiles extends StatelessWidget {
  const LinearProfiles({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ...AppIcons.profiles.asMap().entries.map((profile) {
              final int indexProfile = profile.key;
              final String itemProfileImg = profile.value;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    margin: const EdgeInsets.all(2),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage(itemProfileImg),
                    ),
                  ),
                  onTap: () =>
                      context.read<ProfileCubit>().changeProfile(indexProfile),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

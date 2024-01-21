import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/core.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final SharedPreferences sharedPreferences;

  ProfileCubit({required this.sharedPreferences})
      : super(ProfileChanged(
          sharedPreferences.getString('PROFILE_IMG') ?? AppIcons.profiles[0],
        ));

  void changeProfile(int indexProfile) {
    final profileImg = AppIcons.profiles[indexProfile];
    sharedPreferences.setString('PROFILE_IMG', profileImg);
    emit(ProfileChanged(profileImg));
  }
}

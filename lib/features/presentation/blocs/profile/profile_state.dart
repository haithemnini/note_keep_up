part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileChanged extends ProfileState {
  final String profileImg;

  const ProfileChanged(this.profileImg);

  @override
  List<Object> get props => [profileImg];
}

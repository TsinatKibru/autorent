part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoadSuccess extends ProfileState {
  final Profile profile;
  ProfileLoadSuccess(this.profile);
}

class ProfileFailure extends ProfileState {
  final String message;
  ProfileFailure(this.message);
}

part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class FetchProfileEvent extends ProfileEvent {
  final String id;
  final bool isupdating;
  FetchProfileEvent({required this.id, this.isupdating = false});
}

class UpdateProfileEvent extends ProfileEvent {
  final Profile profile;
  UpdateProfileEvent(this.profile);
}

class AddFavoriteEvent extends ProfileEvent {
  final String profileId;
  final int favoriteId;

  AddFavoriteEvent(this.profileId, this.favoriteId);
}

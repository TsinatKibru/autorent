import 'package:car_rent/core/common/domain/usecases/add_favorites.dart';

import 'package:car_rent/core/common/domain/usecases/get_profile.dart';
import 'package:car_rent/core/common/entities/profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfile getProfile;
  final UpdateProfile updateProfile;
  final AddFavorite addFavorite;

  ProfileBloc({
    required this.getProfile,
    required this.updateProfile,
    required this.addFavorite,
  }) : super(ProfileInitial()) {
    on<FetchProfileEvent>(_onFetchProfile);
    on<UpdateProfileEvent>(_onUpdateProfile);
    on<AddFavoriteEvent>(_onAddFavorite);
  }

  void _onAddFavorite(
      AddFavoriteEvent event, Emitter<ProfileState> emit) async {
    // emit(ProfileLoading());
    final result = await addFavorite(event.profileId, event.favoriteId);

    result.fold(
      (failure) => emit(ProfileFailure(failure.message)),
      (_) => add(FetchProfileEvent(
          id: event.profileId, isupdating: true)), // Refresh profile
    );
  }

  void _onFetchProfile(
      FetchProfileEvent event, Emitter<ProfileState> emit) async {
    if (!event.isupdating) {
      print("loading profile...................................");
      // emit(ProfileLoading());
    }
    final res = await getProfile(event.id);
    res.fold(
      (failure) => emit(ProfileFailure(failure.message)),
      (profile) => emit(ProfileLoadSuccess(profile)),
    );
  }

  // void _onFetchVehicleOwnerProfile(
  //     FetchVehicleOwnerProfileEvent event, Emitter<ProfileState> emit) async {
  //   emit(VehicleOwnerProfileLoading());
  //   final res = await getProfile(event.hostId);
  //   res.fold(
  //     (failure) => emit(VehicleOwnerProfileFailure(failure.message)),
  //     (profile) => emit(VehicleOwnerProfileLoadSuccess(profile)),
  //   );
  // }

  void _onUpdateProfile(
      UpdateProfileEvent event, Emitter<ProfileState> emit) async {
    // emit(ProfileLoading());
    final res = await updateProfile(event.profile);
    res.fold(
      (failure) => emit(ProfileFailure(failure.message)),
      (_) => add(FetchProfileEvent(id: event.profile.id, isupdating: true)),
    );
  }
}


// context.read<ProfileBloc>().add(AddFavoriteEvent(profileId, favoriteId));
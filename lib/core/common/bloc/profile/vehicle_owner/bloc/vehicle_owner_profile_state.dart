part of 'vehicle_owner_profile_bloc.dart';

@immutable
abstract class VehicleOwnerProfileState {}

class VehicleOwnerProfileInitial extends VehicleOwnerProfileState {}

class VehicleOwnerProfileLoading extends VehicleOwnerProfileState {}

class VehicleOwnerProfileFailure extends VehicleOwnerProfileState {
  final String message;

  VehicleOwnerProfileFailure(this.message);
}

class VehicleOwnerProfileLoadSuccess extends VehicleOwnerProfileState {
  final Profile vehicleOwnerProfile;

  VehicleOwnerProfileLoadSuccess(this.vehicleOwnerProfile);
}

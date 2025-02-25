part of 'vehicle_owner_profile_bloc.dart';

@immutable
abstract class VehicleOwnerProfileEvent {}

class FetchVehicleOwnerProfileEvent extends VehicleOwnerProfileEvent {
  final String hostId;

  FetchVehicleOwnerProfileEvent(this.hostId);
}

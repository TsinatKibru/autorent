part of 'vehicle_bloc.dart';

@immutable
abstract class VehicleEvent {}

class FetchVehiclesEvent extends VehicleEvent {
  final int page;
  final int limit;

  FetchVehiclesEvent({required this.page, required this.limit});
}

class CreateVehicleEvent extends VehicleEvent {
  final Vehicle vehicle;
  CreateVehicleEvent(this.vehicle);
}

class UpdateVehicleEvent extends VehicleEvent {
  final int id;
  final Vehicle vehicle;
  UpdateVehicleEvent(this.id, this.vehicle);
}

class DeleteVehicleEvent extends VehicleEvent {
  final int id;
  DeleteVehicleEvent(this.id);
}

class FetchTopRatedVehiclesEvent extends VehicleEvent {
  final int limit;

  FetchTopRatedVehiclesEvent({required this.limit});
}

class SearchVehiclesEvent extends VehicleEvent {
  final String query;
  final int page;
  final int limit;

  SearchVehiclesEvent({
    required this.query,
    required this.page,
    required this.limit,
  });
}

class FetchCurrentUserVehiclesEvent extends VehicleEvent {
  final String hostId;

  FetchCurrentUserVehiclesEvent({required this.hostId});
}

class FetchFavoriteVehiclesEvent extends VehicleEvent {
  final List<int> ids;
  FetchFavoriteVehiclesEvent(this.ids);
}

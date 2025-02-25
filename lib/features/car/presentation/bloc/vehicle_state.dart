part of 'vehicle_bloc.dart';

@immutable
abstract class VehicleState {}

class VehicleInitial extends VehicleState {}

class VehicleLoading extends VehicleState {}

class VehicleLoadSuccess extends VehicleState {
  final List<Vehicle> vehicles;
  final bool hasMore;

  VehicleLoadSuccess(this.vehicles, {required this.hasMore});
}

class VehicleFailure extends VehicleState {
  final String message;
  VehicleFailure(this.message);
}

class TopRatedVehicleState extends VehicleState {
  final List<Vehicle> topRatedVehicles;

  TopRatedVehicleState(this.topRatedVehicles);
}

class SearchVehicleState extends VehicleState {
  final List<Vehicle> searchResults;
  final bool hasMore;

  SearchVehicleState(this.searchResults, {required this.hasMore});
}

class TopRatedVehicleFailure extends VehicleState {
  final String message;

  TopRatedVehicleFailure(this.message);
}

class SearchVehicleFailure extends VehicleState {
  final String message;

  SearchVehicleFailure(this.message);
}

class TopRatedVehicleLoading extends VehicleState {}

class SearchVehicleLoading extends VehicleState {}

//

class CurrentUserVehiclesLoading extends VehicleState {}

class CurrentUserVehiclesLoadSuccess extends VehicleState {
  final List<Vehicle> vehicles;

  CurrentUserVehiclesLoadSuccess(this.vehicles);
}

class CurrentUserVehiclesFailure extends VehicleState {
  final String message;

  CurrentUserVehiclesFailure(this.message);
}

class FavoriteVehiclesLoadSuccess extends VehicleState {
  final List<Vehicle> vehicles;
  FavoriteVehiclesLoadSuccess(this.vehicles);
}

class FavoriteVehiclesLoading extends VehicleState {}

class FavoriteVehiclesFailure extends VehicleState {
  final String message;

  FavoriteVehiclesFailure(this.message);
}

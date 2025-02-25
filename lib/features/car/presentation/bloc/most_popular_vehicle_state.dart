part of 'most_popular_vehicle_bloc.dart';

@immutable
abstract class MostPopularVehicleState {}

class MostPopularVehicleInitial extends MostPopularVehicleState {}

class MostPopularVehicleLoading extends MostPopularVehicleState {}

class MostPopularVehicleLoadSuccess extends MostPopularVehicleState {
  final List<Vehicle> vehicles;
  final bool hasMore;

  MostPopularVehicleLoadSuccess(this.vehicles, {this.hasMore = true});
}

class MostPopularVehicleFailure extends MostPopularVehicleState {
  final String message;

  MostPopularVehicleFailure(this.message);
}

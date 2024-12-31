part of 'vehicle_bloc.dart';

@immutable
abstract class VehicleState {}

class VehicleInitial extends VehicleState {}

class VehicleLoading extends VehicleState {}

class VehicleLoadSuccess extends VehicleState {
  final List<Vehicle> vehicles;
  VehicleLoadSuccess(this.vehicles);
}

class VehicleFailure extends VehicleState {
  final String message;
  VehicleFailure(this.message);
}

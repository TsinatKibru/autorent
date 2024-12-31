part of 'vehicle_bloc.dart';

@immutable
abstract class VehicleEvent {}

class FetchVehiclesEvent extends VehicleEvent {}

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

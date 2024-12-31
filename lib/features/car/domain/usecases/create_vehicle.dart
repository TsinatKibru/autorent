import 'package:car_rent/core/error/failure.dart';
import 'package:car_rent/core/usecase/usecase.dart';
import 'package:car_rent/features/car/domain/entities/vehicle.dart';
import 'package:car_rent/features/car/domain/repository/vehicle_repository.dart';

import 'package:fpdart/fpdart.dart';

class CreateVehicle implements Usecase<Unit, Vehicle> {
  final VehiclesRepository repository;

  CreateVehicle(this.repository);

  @override
  Future<Either<Failure, Unit>> call(Vehicle vehicle) async {
    return await repository.createVehicle(vehicle);
  }
}

class CreateVehicleParams {
  final Vehicle vehicle;

  CreateVehicleParams(this.vehicle);
}

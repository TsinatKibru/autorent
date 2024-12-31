import 'package:car_rent/core/error/failure.dart';
import 'package:car_rent/core/usecase/usecase.dart';
import 'package:car_rent/features/car/domain/entities/vehicle.dart';
import 'package:car_rent/features/car/domain/repository/vehicle_repository.dart';

import 'package:fpdart/fpdart.dart';

class UpdateVehicle implements Usecase<Unit, UpdateVehicleParams> {
  final VehiclesRepository repository;

  UpdateVehicle(this.repository);

  @override
  Future<Either<Failure, Unit>> call(UpdateVehicleParams params) async {
    return await repository.updateVehicle(params.id, params.vehicle);
  }
}

class UpdateVehicleParams {
  final int id;
  final Vehicle vehicle;

  UpdateVehicleParams({
    required this.id,
    required this.vehicle,
  });
}

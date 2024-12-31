import 'package:car_rent/core/error/failure.dart';
import 'package:car_rent/core/usecase/usecase.dart';
import 'package:car_rent/features/car/domain/repository/vehicle_repository.dart';

import 'package:fpdart/fpdart.dart';

class DeleteVehicle implements Usecase<Unit, VehicleIdParams> {
  final VehiclesRepository repository;

  DeleteVehicle(this.repository);

  @override
  Future<Either<Failure, Unit>> call(VehicleIdParams params) async {
    return await repository.deleteVehicle(params.id);
  }
}

class VehicleIdParams {
  final int id;

  VehicleIdParams(this.id);
}

import 'package:car_rent/core/error/failure.dart';
import 'package:car_rent/core/usecase/usecase.dart';
import 'package:car_rent/features/car/domain/entities/vehicle.dart';
import 'package:car_rent/features/car/domain/repository/vehicle_repository.dart';

import 'package:fpdart/fpdart.dart';

class GetVehicleById implements Usecase<Vehicle, VehicleIdParams> {
  final VehiclesRepository repository;

  GetVehicleById(this.repository);

  @override
  Future<Either<Failure, Vehicle>> call(VehicleIdParams params) async {
    return await repository.getVehicleById(params.id);
  }
}

class VehicleIdParams {
  final int id;

  VehicleIdParams({required this.id});
}

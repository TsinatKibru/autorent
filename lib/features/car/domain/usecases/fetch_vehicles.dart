import 'package:car_rent/core/error/failure.dart';
import 'package:car_rent/core/usecase/usecase.dart';
import 'package:car_rent/features/car/domain/entities/vehicle.dart';
import 'package:car_rent/features/car/domain/repository/vehicle_repository.dart';

import 'package:fpdart/fpdart.dart';

class FetchVehicles implements Usecase<List<Vehicle>, NoParams> {
  final VehiclesRepository repository;

  FetchVehicles(this.repository);

  @override
  Future<Either<Failure, List<Vehicle>>> call(NoParams params) async {
    return await repository.fetchVehicles();
  }
}

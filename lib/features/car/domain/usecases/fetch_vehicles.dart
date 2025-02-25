import 'package:car_rent/core/error/failure.dart';
import 'package:car_rent/core/usecase/usecase.dart';
import 'package:car_rent/features/car/domain/entities/vehicle.dart';
import 'package:car_rent/features/car/domain/repository/vehicle_repository.dart';

import 'package:fpdart/fpdart.dart';

// class FetchVehicles implements Usecase<List<Vehicle>, NoParams> {
//   final VehiclesRepository repository;

//   FetchVehicles(this.repository);

//   @override
//   Future<Either<Failure, List<Vehicle>>> call(NoParams params) async {
//     return await repository.fetchVehicles();
//   }
// }

class FetchVehicles implements Usecase<List<Vehicle>, FetchVehiclesParams> {
  final VehiclesRepository repository;

  FetchVehicles(this.repository);

  @override
  Future<Either<Failure, List<Vehicle>>> call(
      FetchVehiclesParams params) async {
    return await repository.fetchVehicles(
        page: params.page, limit: params.limit);
  }
}

class FetchVehiclesParams {
  final int page;
  final int limit;

  FetchVehiclesParams({required this.page, required this.limit});
}

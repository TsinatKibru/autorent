import 'package:car_rent/core/error/failure.dart';
import 'package:car_rent/core/usecase/usecase.dart';
import 'package:car_rent/features/car/domain/entities/vehicle.dart';
import 'package:car_rent/features/car/domain/repository/vehicle_repository.dart';
import 'package:fpdart/fpdart.dart';

class FetchTopRatedVehicles
    implements Usecase<List<Vehicle>, TopRatedVehiclesParams> {
  final VehiclesRepository repository;

  FetchTopRatedVehicles(this.repository);

  @override
  Future<Either<Failure, List<Vehicle>>> call(
      TopRatedVehiclesParams params) async {
    return await repository.fetchTopRatedVehicles(limit: params.limit);
  }
}

class TopRatedVehiclesParams {
  final int limit;

  TopRatedVehiclesParams({required this.limit});
}

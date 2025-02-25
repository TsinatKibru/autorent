import 'package:car_rent/core/error/failure.dart';
import 'package:car_rent/core/usecase/usecase.dart';
import 'package:car_rent/features/car/domain/entities/vehicle.dart';
import 'package:car_rent/features/car/domain/repository/vehicle_repository.dart';
import 'package:fpdart/fpdart.dart';

class FetchFavoriteVehicles
    implements Usecase<List<Vehicle>, FetchFavoriteVehiclesParams> {
  final VehiclesRepository repository;

  FetchFavoriteVehicles(this.repository);

  @override
  Future<Either<Failure, List<Vehicle>>> call(
      FetchFavoriteVehiclesParams params) async {
    return await repository.fetchFavoriteVehicles(params.ids);
  }
}

class FetchFavoriteVehiclesParams {
  final List<int> ids;
  FetchFavoriteVehiclesParams(this.ids);
}

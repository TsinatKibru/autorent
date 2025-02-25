import 'package:car_rent/core/common/entities/uploaded_image.dart';
import 'package:car_rent/core/error/failure.dart';
import 'package:car_rent/features/car/domain/entities/vehicle.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class VehiclesRepository {
  // Future<Either<Failure, List<Vehicle>>> fetchVehicles();
  Future<Either<Failure, List<Vehicle>>> fetchVehicles(
      {required int page, required int limit});

  Future<Either<Failure, Vehicle>> getVehicleById(int id);

  Future<Either<Failure, List<Vehicle>>> getVehiclesByHostId(String id);

  Future<Either<Failure, Unit>> createVehicle(Vehicle vehicle);
  Future<Either<Failure, Vehicle>> updateVehicle(int id, Vehicle vehicle);
  Future<Either<Failure, Unit>> deleteVehicle(int id);
  Future<Either<Failure, List<Vehicle>>> fetchTopRatedVehicles(
      {required int limit});
  Future<Either<Failure, List<Vehicle>>> searchVehicles({
    required String query,
    required int page,
    required int limit,
  });
  Future<Either<Failure, List<Vehicle>>> fetchFavoriteVehicles(List<int> ids);
}

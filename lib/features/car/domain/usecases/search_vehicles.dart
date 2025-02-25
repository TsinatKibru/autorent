import 'package:car_rent/core/error/failure.dart';
import 'package:car_rent/core/usecase/usecase.dart';
import 'package:car_rent/features/car/domain/entities/vehicle.dart';
import 'package:car_rent/features/car/domain/repository/vehicle_repository.dart';
import 'package:fpdart/fpdart.dart';

class SearchVehicles implements Usecase<List<Vehicle>, SearchVehiclesParams> {
  final VehiclesRepository repository;

  SearchVehicles(this.repository);

  @override
  Future<Either<Failure, List<Vehicle>>> call(
      SearchVehiclesParams params) async {
    return await repository.searchVehicles(
      query: params.query,
      page: params.page,
      limit: params.limit,
    );
  }
}

class SearchVehiclesParams {
  final String query;
  final int page;
  final int limit;

  SearchVehiclesParams({
    required this.query,
    required this.page,
    required this.limit,
  });
}

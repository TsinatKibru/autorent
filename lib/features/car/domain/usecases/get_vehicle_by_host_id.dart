import 'package:car_rent/core/error/failure.dart';
import 'package:car_rent/core/usecase/usecase.dart';
import 'package:car_rent/features/car/domain/entities/vehicle.dart';
import 'package:car_rent/features/car/domain/repository/vehicle_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetVehicleByHostId implements Usecase<List<Vehicle>, HostIdParams> {
  final VehiclesRepository repository;

  GetVehicleByHostId(this.repository);

  @override
  Future<Either<Failure, List<Vehicle>>> call(HostIdParams params) async {
    return await repository.getVehiclesByHostId(params.id);
  }
}

class HostIdParams {
  final String id;

  HostIdParams({required this.id});
}

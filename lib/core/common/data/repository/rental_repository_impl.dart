import 'package:car_rent/core/common/data/datasources/rental_remote_data_source.dart';
import 'package:car_rent/core/common/data/models/rental_model.dart';
import 'package:car_rent/core/common/domain/repository/rental_repository.dart';
import 'package:car_rent/core/common/entities/rental.dart';
import 'package:car_rent/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

class RentalRepositoryImpl implements RentalRepository {
  final RentalRemoteDataSource remoteDataSource;

  RentalRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, Unit>> createRental(Rental rental) async {
    try {
      final rentalModel = RentalModel(
        id: rental.id,
        vehicleId: rental.vehicleId,
        profileId: rental.profileId,
        hostId: rental.hostId,
        startTime: rental.startTime,
        endTime: rental.endTime,
        pickupLocation: rental.pickupLocation,
        totalCost: rental.totalCost,
        status: rental.status,
        responseTime: rental.responseTime,
      );
      await remoteDataSource.createRental(rentalModel);
      return right(unit);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateRentalStatus(
      int rentalId, String status) async {
    try {
      await remoteDataSource.updateRentalStatus(rentalId, status);
      return right(unit);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Rental>>> getRentals() async {
    try {
      final rentals = await remoteDataSource.getRentals();
      return right(rentals);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}

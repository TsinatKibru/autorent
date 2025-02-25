import 'package:car_rent/core/common/entities/rental.dart';
import 'package:car_rent/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract class RentalRepository {
  Future<Either<Failure, Unit>> createRental(Rental rental);
  Future<Either<Failure, Unit>> updateRentalStatus(int rentalId, String status);
  Future<Either<Failure, List<Rental>>> getRentals();
  // Stream<Either<Failure, List<Rental>>> subscribeToTripsByProfileId(
  //     String profileId, bool? host);
}

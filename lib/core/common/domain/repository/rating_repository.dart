import 'package:car_rent/core/common/entities/rating.dart';
import 'package:car_rent/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract class RatingRepository {
  Future<Either<Failure, Unit>> createRating(AverageRating rating);
  Future<Either<Failure, List<Rating>>> getRatings();
  Future<Either<Failure, List<Rating>>> getRatingsByVehicleId(int vehicleId);
  Future<Either<Failure, List<Rating>>> getRatingsByProfileId(String profileId);
  Future<Either<Failure, AverageRating>> getAverageRatingByVehicleId(
      int vehicleId);
}

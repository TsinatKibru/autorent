import 'package:car_rent/core/common/domain/repository/rating_repository.dart';
import 'package:car_rent/core/common/entities/rating.dart';
import 'package:car_rent/core/error/failure.dart';
import 'package:car_rent/core/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';

class GetRatingsByVehicleId implements Usecase<List<Rating>, int> {
  final RatingRepository repository;

  GetRatingsByVehicleId(this.repository);

  @override
  Future<Either<Failure, List<Rating>>> call(int vehicleId) async {
    return await repository.getRatingsByVehicleId(vehicleId);
  }
}

class GetRatingsByProfileId implements Usecase<List<Rating>, String> {
  final RatingRepository repository;

  GetRatingsByProfileId(this.repository);

  @override
  Future<Either<Failure, List<Rating>>> call(String profileId) async {
    return await repository.getRatingsByProfileId(profileId);
  }
}

class GetAverageRatingByVehicleId implements Usecase<AverageRating, int> {
  final RatingRepository repository;

  GetAverageRatingByVehicleId(this.repository);

  @override
  Future<Either<Failure, AverageRating>> call(int vehicleId) async {
    return await repository.getAverageRatingByVehicleId(vehicleId);
  }
}

class CreateRating implements Usecase<Unit, AverageRating> {
  final RatingRepository repository;

  CreateRating(this.repository);

  @override
  Future<Either<Failure, Unit>> call(AverageRating rating) async {
    return await repository.createRating(rating);
  }
}

class GetRatings implements Usecase<List<Rating>, NoParams> {
  final RatingRepository repository;

  GetRatings(this.repository);

  @override
  Future<Either<Failure, List<Rating>>> call(NoParams params) async {
    return await repository.getRatings();
  }
}

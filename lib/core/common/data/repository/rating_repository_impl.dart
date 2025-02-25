import 'package:car_rent/core/common/data/datasources/rating_remote_data_source.dart';
import 'package:car_rent/core/common/data/models/rating_model.dart';
import 'package:car_rent/core/common/domain/repository/rating_repository.dart';
import 'package:car_rent/core/common/entities/rating.dart';
import 'package:car_rent/core/error/exceptions.dart';
import 'package:car_rent/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

class RatingRepositoryImpl implements RatingRepository {
  final RatingRemoteDataSource remoteDataSource;

  RatingRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, Unit>> createRating(AverageRating rating) async {
    try {
      final ratingModel = AverageRatingModel(
        id: rating.id,
        profileId: rating.profileId,
        vehicleId: rating.vehicleId,
        cleanliness: rating.cleanliness,
        maintenance: rating.maintenance,
        communication: rating.communication,
        overallRating: rating.overallRating,
        comment: rating.comment,
        date: rating.date,
      );
      await remoteDataSource.createRating(ratingModel);
      return right(unit);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Rating>>> getRatings() async {
    try {
      final ratings = await remoteDataSource.getRatings();
      return right(ratings);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Rating>>> getRatingsByVehicleId(
      int vehicleId) async {
    try {
      final ratings = await remoteDataSource.getRatingsByVehicleId(vehicleId);
      return right(ratings.map((model) => model.toEntity()).toList());
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Rating>>> getRatingsByProfileId(
      String profileId) async {
    try {
      final ratings = await remoteDataSource.getRatingsByProfileId(profileId);
      return right(ratings.map((model) => model.toEntity()).toList());
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, AverageRating>> getAverageRatingByVehicleId(
      int vehicleId) async {
    try {
      final averageRating =
          await remoteDataSource.getAverageRatingByVehicleId(vehicleId);
      return right(averageRating.toEntity());
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}

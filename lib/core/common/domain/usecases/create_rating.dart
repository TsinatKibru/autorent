import 'package:car_rent/core/common/domain/repository/rating_repository.dart';
import 'package:car_rent/core/common/entities/rating.dart';
import 'package:car_rent/core/error/failure.dart';
import 'package:car_rent/core/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';

class CreateRating implements Usecase<Unit, AverageRating> {
  final RatingRepository repository;

  CreateRating(this.repository);

  @override
  Future<Either<Failure, Unit>> call(AverageRating rating) async {
    return await repository.createRating(rating);
  }
}

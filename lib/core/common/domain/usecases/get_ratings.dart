import 'package:car_rent/core/common/domain/repository/rating_repository.dart';
import 'package:car_rent/core/common/entities/rating.dart';
import 'package:car_rent/core/error/failure.dart';
import 'package:car_rent/core/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';

class GetRatings implements Usecase<List<Rating>, NoParams> {
  final RatingRepository repository;

  GetRatings(this.repository);

  @override
  Future<Either<Failure, List<Rating>>> call(NoParams params) async {
    return await repository.getRatings();
  }
}

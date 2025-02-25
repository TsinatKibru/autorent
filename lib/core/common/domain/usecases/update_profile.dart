import 'package:car_rent/core/common/domain/repository/profile_repository.dart';
import 'package:car_rent/core/common/entities/profile.dart';
import 'package:car_rent/core/error/failure.dart';
import 'package:car_rent/core/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';

class UpdateProfile implements Usecase<Unit, Profile> {
  final ProfileRepository repository;

  UpdateProfile(this.repository);

  @override
  Future<Either<Failure, Unit>> call(Profile profile) async {
    return await repository.updateProfile(profile);
  }
}

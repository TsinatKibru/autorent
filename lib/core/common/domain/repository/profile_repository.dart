import 'package:car_rent/core/common/entities/profile.dart';
import 'package:car_rent/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Profile>> getProfile(String id);
  Future<Either<Failure, Unit>> updateProfile(Profile profile);
}

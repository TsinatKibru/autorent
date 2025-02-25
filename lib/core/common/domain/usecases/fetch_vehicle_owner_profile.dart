import 'package:car_rent/core/common/domain/repository/profile_repository.dart';
import 'package:car_rent/core/common/entities/profile.dart';
import 'package:car_rent/core/error/failure.dart';
import 'package:car_rent/core/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';

class FetchVehicleOwnerProfile implements Usecase<Profile, String> {
  final ProfileRepository repository;

  FetchVehicleOwnerProfile(this.repository);

  @override
  Future<Either<Failure, Profile>> call(String id) async {
    return await repository.getProfile(id);
  }
}

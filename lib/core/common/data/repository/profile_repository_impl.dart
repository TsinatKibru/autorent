import 'package:car_rent/core/common/data/datasources/profile_datasource.dart';
import 'package:car_rent/core/common/data/models/profile_model.dart';
import 'package:car_rent/core/common/domain/repository/profile_repository.dart';
import 'package:car_rent/core/common/entities/profile.dart';
import 'package:car_rent/core/error/exceptions.dart';
import 'package:car_rent/core/error/failure.dart';

import 'package:fpdart/fpdart.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, Profile>> getProfile(String id) async {
    try {
      final profile = await remoteDataSource.getProfile(id);
      return right(profile);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateProfile(Profile profile) async {
    try {
      final profileModel = ProfileModel(
        id: profile.id,
        updatedAt: profile.updatedAt,
        name: profile.name,
        lastName: profile.lastName,
        phoneNumber: profile.phoneNumber,
        driverLicenseImageUrl: profile.driverLicenseImageUrl,
        role: profile.role,
        avatar: profile.avatar,
        walletId: profile.walletId,
        location: profile.location,
        favorites: profile.favorites,
      );
      await remoteDataSource.updateProfile(profileModel);
      return right(unit);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}

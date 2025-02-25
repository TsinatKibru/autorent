import 'package:car_rent/core/common/domain/repository/profile_repository.dart';
import 'package:car_rent/core/common/entities/profile.dart';
import 'package:car_rent/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

class AddFavorite {
  final ProfileRepository repository;

  AddFavorite(this.repository);

  Future<Either<Failure, Unit>> call(String profileId, int favoriteId) async {
    // Fetch the profile
    final result = await repository.getProfile(profileId);

    return result.fold(
      (failure) => left(failure),
      (profile) async {
        if (profile.favorites != null &&
            !profile.favorites!.contains(favoriteId)) {
          final updatedProfile = Profile(
            id: profile.id,
            updatedAt: DateTime.now(),
            name: profile.name,
            lastName: profile.lastName,
            phoneNumber: profile.phoneNumber,
            driverLicenseImageUrl: profile.driverLicenseImageUrl,
            role: profile.role,
            avatar: profile.avatar,
            location: profile.location,
            favorites: [...profile.favorites!, favoriteId],
          );
          return await repository.updateProfile(updatedProfile);
        }

        // Add favorite
        else {
          // If favorite already exists, return a failure
          return right(unit);
        }
      },
    );
  }
}

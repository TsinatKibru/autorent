import 'package:car_rent/core/common/data/datasources/image_remote_data_source.dart';
import 'package:car_rent/core/common/domain/repository/image_repository.dart';
import 'package:car_rent/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

class ImageRepositoryImpl implements ImageRepository {
  final ImageRemoteDataSource remoteDataSource;

  ImageRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, String>> uploadImage(
      String path, String bucketName, String userId) async {
    try {
      final url = await remoteDataSource.uploadImage(path, bucketName, userId);
      return Right(url);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getSignedUrl(
      String publicUrl, int durationInSeconds) async {
    try {
      final signedUrl =
          await remoteDataSource.getSignedUrl(publicUrl, durationInSeconds);
      return Right(signedUrl);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}

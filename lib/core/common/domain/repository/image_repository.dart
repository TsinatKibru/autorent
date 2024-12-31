import 'package:car_rent/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract class ImageRepository {
  Future<Either<Failure, String>> uploadImage(
      String path, String bucketName, String userId);
  Future<Either<Failure, String>> getSignedUrl(
      String publicUrl, int durationInSeconds);
}

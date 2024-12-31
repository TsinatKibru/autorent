import 'package:car_rent/core/common/domain/repository/image_repository.dart';
import 'package:car_rent/core/error/failure.dart';
import 'package:car_rent/core/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';

class UploadImage implements Usecase<String, UploadImageParams> {
  final ImageRepository repository;

  UploadImage(this.repository);

  @override
  Future<Either<Failure, String>> call(UploadImageParams params) {
    return repository.uploadImage(
        params.path, params.bucketName, params.userId);
  }
}

class UploadImageParams {
  final String path;
  final String bucketName;
  final String userId;

  UploadImageParams(
      {required this.path, required this.bucketName, required this.userId});
}

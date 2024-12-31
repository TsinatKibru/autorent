import 'package:car_rent/core/common/domain/repository/image_repository.dart';
import 'package:car_rent/core/error/failure.dart';
import 'package:car_rent/core/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';

class GetSignedUrl implements Usecase<String, GetSignedUrlParams> {
  final ImageRepository repository;

  GetSignedUrl(this.repository);

  @override
  Future<Either<Failure, String>> call(GetSignedUrlParams params) {
    return repository.getSignedUrl(params.publicUrl, params.durationInSeconds);
  }
}

class GetSignedUrlParams {
  final String publicUrl;
  final int durationInSeconds;

  GetSignedUrlParams({
    required this.publicUrl,
    required this.durationInSeconds,
  });
}

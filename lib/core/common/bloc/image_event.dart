part of 'image_bloc.dart';

@immutable
abstract class ImageEvent {}

class UploadImageEvent extends ImageEvent {
  final String path;
  final String bucketName;
  final String userId;

  UploadImageEvent({
    required this.path,
    required this.bucketName,
    required this.userId,
  });
}

class GetSignedUrlEvent extends ImageEvent {
  final String publicUrl;
  final int durationInSeconds;

  GetSignedUrlEvent({
    required this.publicUrl,
    required this.durationInSeconds,
  });
}

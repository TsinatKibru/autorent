part of 'image_bloc.dart';

@immutable
abstract class ImageState {}

class ImageInitial extends ImageState {}

class ImageUploading extends ImageState {}

class ImageUploadSuccess extends ImageState {
  final String url;
  ImageUploadSuccess(this.url);
}

class ImageUploadFailure extends ImageState {
  final String message;
  ImageUploadFailure(this.message);
}

class GetSignedUrlLoading extends ImageState {}

class GetSignedUrlSuccess extends ImageState {
  final String signedUrl;
  GetSignedUrlSuccess(this.signedUrl);
}

class GetSignedUrlFailure extends ImageState {
  final String message;
  GetSignedUrlFailure(this.message);
}

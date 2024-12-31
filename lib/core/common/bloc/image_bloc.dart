import 'package:car_rent/core/common/domain/usecases/get_signed_url.dart';
import 'package:car_rent/core/common/domain/usecases/upload_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final UploadImage uploadImage;
  final GetSignedUrl getSignedUrl;

  ImageBloc({
    required this.uploadImage,
    required this.getSignedUrl,
  }) : super(ImageInitial()) {
    on<UploadImageEvent>((event, emit) async {
      emit(ImageUploading());
      final result = await uploadImage(UploadImageParams(
        path: event.path,
        bucketName: event.bucketName,
        userId: event.userId,
      ));
      result.fold(
        (failure) => emit(ImageUploadFailure(failure.message)),
        (url) => emit(ImageUploadSuccess(url)),
      );
    });

    on<GetSignedUrlEvent>((event, emit) async {
      emit(GetSignedUrlLoading());
      final result = await getSignedUrl(GetSignedUrlParams(
        publicUrl: event.publicUrl,
        durationInSeconds: event.durationInSeconds,
      ));
      result.fold(
        (failure) => emit(GetSignedUrlFailure(failure.message)),
        (signedUrl) => emit(GetSignedUrlSuccess(signedUrl)),
      );
    });
  }
}

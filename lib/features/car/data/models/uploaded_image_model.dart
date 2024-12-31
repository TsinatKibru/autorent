import 'package:car_rent/core/common/entities/uploaded_image.dart';

class UploadedImageModel extends UploadedImage {
  UploadedImageModel({required String url, required String name})
      : super(url: url, name: name);

  factory UploadedImageModel.fromJson(Map<String, dynamic> json) {
    return UploadedImageModel(url: json['url'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {'url': url, 'name': name};
  }
}

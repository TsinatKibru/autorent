import 'dart:io';
import 'package:car_rent/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ImageRemoteDataSource {
  Future<String> uploadImage(String path, String bucketName, String userId);
  Future<String> getSignedUrl(String publicUrl, int durationInSeconds);
}

class ImageRemoteDataSourceImpl implements ImageRemoteDataSource {
  final SupabaseClient supabaseClient;

  ImageRemoteDataSourceImpl(this.supabaseClient);

  // @override
  // Future<String> uploadImage(
  //     String path, String bucketName, String userId) async {
  //   print("uploading image");
  //   try {
  //     final file = File(path);
  //     final fileName =
  //         '$userId${DateTime.now().millisecondsSinceEpoch}_${file.uri.pathSegments.last}';

  //     final response = await supabaseClient.storage
  //         .from(bucketName)
  //         .upload('public/$fileName', file);
  //     if (response.isEmpty) {
  //       throw Exception('Upload failed');
  //     }

  //     final publicUrl = supabaseClient.storage
  //         .from(bucketName)
  //         .getPublicUrl('public/$fileName');

  //     if (publicUrl.isEmpty) {
  //       throw ServerException(
  //           'Failed to generate public URL for the uploaded file.');
  //     }

  //     // Return the UploadedImageModel
  //     return publicUrl;
  //   } catch (e) {
  //     throw ServerException('Failed to upload image: $e');
  //   }
  // }
  @override
  Future<String> uploadImage(
      String path, String bucketName, String userId) async {
    print("Uploading image...");
    try {
      // Log the file path being uploaded
      print("File path: $path");

      final file = File(path);

      // Log the file name being generated
      final fileName =
          '$userId${DateTime.now().millisecondsSinceEpoch}_${file.uri.pathSegments.last}';
      print("Generated file name: $fileName");

      // Upload the file to the Supabase storage bucket
      final response = await supabaseClient.storage
          .from(bucketName)
          .upload('public/$fileName', file);

      // Log the response status
      if (response.isEmpty) {
        print("Upload failed: Response is empty.");
        throw Exception('Upload failed');
      }
      print("Upload successful. Response: $response");

      // Get the public URL for the uploaded file
      final publicUrl = supabaseClient.storage
          .from(bucketName)
          .getPublicUrl('public/$fileName');

      // Log the public URL
      if (publicUrl.isEmpty) {
        print("Failed to generate public URL.");
        throw ServerException(
            'Failed to generate public URL for the uploaded file.');
      }
      print("Public URL generated: $publicUrl");

      // Return the public URL of the uploaded image
      return publicUrl;
    } catch (e) {
      // Log the exception error
      print("Error during image upload: $e");
      throw ServerException('Failed to upload image: $e');
    }
  }

  @override
  Future<String> getSignedUrl(String publicUrl, int durationInSeconds) async {
    try {
      // Parse the bucket name, folder, and file path from the public URL
      final uri = Uri.parse(publicUrl);
      final segments = uri.pathSegments;

      if (segments.length < 4) {
        throw ServerException('Invalid public URL format');
      }

      // Extract bucket name and file path
      final bucketName = segments[2]; // Third segment is the bucket name
      final filePath = segments.skip(3).join('/'); // Rest is the file path

      // Generate a signed URL
      final signedUrl = await supabaseClient.storage
          .from(bucketName)
          .createSignedUrl(filePath, durationInSeconds);

      if (signedUrl.isEmpty) {
        throw ServerException('Failed to generate signed URL');
      }

      return signedUrl;
    } catch (e) {
      throw ServerException('Failed to generate signed URL: $e');
    }
  }
}

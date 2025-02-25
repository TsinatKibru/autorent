import 'package:car_rent/core/common/entities/profile.dart';

class ProfileModel extends Profile {
  ProfileModel({
    required String id,
    DateTime? updatedAt,
    required String name,
    String? lastName,
    String? phoneNumber,
    String? driverLicenseImageUrl,
    String? role,
    String? avatar,
    int? walletId,
    String? location,
    List<int>? favorites,
  }) : super(
          id: id,
          updatedAt: updatedAt,
          name: name,
          lastName: lastName,
          phoneNumber: phoneNumber,
          driverLicenseImageUrl: driverLicenseImageUrl,
          role: role,
          avatar: avatar,
          walletId: walletId,
          location: location,
          favorites: favorites,
        );

  // Convert from JSON with correct mapping
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] ?? '',
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      name: json['name'] ?? '',
      lastName: json['lastname'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      driverLicenseImageUrl: json['driver_license_image_url'] ?? '',
      role: json['role'] ?? '',
      avatar: json['avatar'],
      walletId: json['wallet_id'],
      location: json['location'],
      favorites: List<int>.from(json['favorites'] ?? []),
    );
  }

  // Convert to JSON with correct mapping
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'updated_at': updatedAt?.toIso8601String(),
      'name': name,
      'lastname': lastName,
      'phone_number': phoneNumber,
      'driver_license_image_url': driverLicenseImageUrl,
      'role': role,
      'avatar': avatar,
      'wallet_id': walletId,
      'location': location,
      'favorites': favorites,
    };
  }
}

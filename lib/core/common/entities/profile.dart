// models/profile.dart
class Profile {
  final String id;
  final DateTime? updatedAt;
  final String name;
  final String? lastName;
  final String? phoneNumber;
  final String? driverLicenseImageUrl;
  final String? role;
  final String? avatar;
  final int? walletId;
  final String? location;

  final List<int>? favorites;

  Profile({
    required this.id,
    this.updatedAt,
    required this.name,
    this.lastName,
    this.phoneNumber,
    this.driverLicenseImageUrl,
    this.role,
    this.avatar,
    this.walletId,
    this.location,
    this.favorites,
  });

  //Convert from JSON
  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      name: json['name'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
      driverLicenseImageUrl: json['driverLicenseImageUrl'],
      role: json['role'],
      avatar: json['avatar'],
      walletId: json['walletId'],
      location: json['location'],
      favorites:
          json['favorites'] != null ? List<int>.from(json['favorites']) : null,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'updatedAt': updatedAt?.toIso8601String(),
      'name': name,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'driverLicenseImageUrl': driverLicenseImageUrl,
      'role': role,
      'avatar': avatar,
      'walletId': walletId,
      'location': location,
      'favorites': favorites,
    };
  }

  // Convert to String
  @override
  String toString() {
    return 'Profile(id: $id, updatedAt: $updatedAt, name: $name, lastName: $lastName, phoneNumber: $phoneNumber, driverLicenseImageUrl: $driverLicenseImageUrl, role: $role, avatar: $avatar, walletId: $walletId, location: $location, favorites: $favorites)';
  }

  Profile copyWith({
    String? id,
    DateTime? updatedAt,
    String? name,
    String? lastName,
    String? phoneNumber,
    String? driverLicenseImageUrl,
    String? role,
    String? avatar,
    int? walletId,
    String? location,
    List<int>? favorites,
  }) {
    return Profile(
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      driverLicenseImageUrl:
          driverLicenseImageUrl ?? this.driverLicenseImageUrl,
      role: role ?? this.role,
      avatar: avatar ?? this.avatar,
      walletId: walletId ?? this.walletId,
      location: location ?? this.location,
      favorites: favorites ?? this.favorites,
    );
  }
}

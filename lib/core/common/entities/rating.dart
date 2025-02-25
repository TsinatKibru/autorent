import 'package:car_rent/core/common/entities/profile.dart';

class AverageRating {
  final int id;
  final String profileId;
  final int vehicleId;
  final int cleanliness;
  final int maintenance;
  final int communication;
  final double overallRating;
  final String? comment;
  final DateTime date;

  AverageRating({
    required this.id,
    required this.profileId,
    required this.vehicleId,
    required this.cleanliness,
    required this.maintenance,
    required this.communication,
    required this.overallRating,
    this.comment,
    required this.date,
  });
}

class Rating {
  final int id;
  final Profile profile; // Replace profileId with Profile object
  final int vehicleId;
  final int cleanliness;
  final int maintenance;
  final int communication;
  final double overallRating;
  final String? comment;
  final DateTime date;

  Rating({
    required this.id,
    required this.profile,
    required this.vehicleId,
    required this.cleanliness,
    required this.maintenance,
    required this.communication,
    required this.overallRating,
    this.comment,
    required this.date,
  });
}

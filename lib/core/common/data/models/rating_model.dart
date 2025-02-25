import 'package:car_rent/core/common/data/models/profile_model.dart';
import 'package:car_rent/core/common/entities/rating.dart';

class AverageRatingModel extends AverageRating {
  AverageRatingModel({
    required int id,
    required String profileId,
    required int vehicleId,
    required int cleanliness,
    required int maintenance,
    required int communication,
    required double overallRating,
    String? comment,
    required DateTime date,
  }) : super(
          id: id,
          profileId: profileId,
          vehicleId: vehicleId,
          cleanliness: cleanliness,
          maintenance: maintenance,
          communication: communication,
          overallRating: overallRating,
          comment: comment,
          date: date,
        );

  factory AverageRatingModel.fromJson(Map<String, dynamic> json) {
    return AverageRatingModel(
      id: json['id'],
      profileId: json['profile'],
      vehicleId: json['vehicle'],
      cleanliness: json['cleanliness'],
      maintenance: json['maintenance'],
      communication: json['communication'],
      overallRating:
          (json['overall_rating'] as num).toDouble(), // Convert to double
      comment: json['comment'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profile': profileId,
      'vehicle': vehicleId,
      'cleanliness': cleanliness,
      'maintenance': maintenance,
      'communication': communication,
      'overall_rating': overallRating,
      'comment': comment,
      'date': date.toIso8601String(),
    };
  }

  AverageRating toEntity() {
    return AverageRating(
      id: id,
      profileId: profileId,
      vehicleId: vehicleId,
      cleanliness: cleanliness,
      maintenance: maintenance,
      communication: communication,
      overallRating: overallRating,
      comment: comment,
      date: date,
    );
  }
}

class RatingModel extends Rating {
  RatingModel({
    required int id,
    required ProfileModel profile,
    required int vehicleId,
    required int cleanliness,
    required int maintenance,
    required int communication,
    required double overallRating,
    String? comment,
    required DateTime date,
  }) : super(
          id: id,
          profile: profile,
          vehicleId: vehicleId,
          cleanliness: cleanliness,
          maintenance: maintenance,
          communication: communication,
          overallRating: overallRating,
          comment: comment,
          date: date,
        );

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      id: json['id'],
      profile: ProfileModel.fromJson(json['profile']), // Fetch profile data
      vehicleId: json['vehicle'],
      cleanliness: json['cleanliness'],
      maintenance: json['maintenance'],
      communication: json['communication'],
      overallRating: (json['overall_rating'] as num).toDouble(),
      comment: json['comment'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profile': profile.toJson(), // Include profile data
      'vehicle': vehicleId,
      'cleanliness': cleanliness,
      'maintenance': maintenance,
      'communication': communication,
      'overall_rating': overallRating,
      'comment': comment,
      'date': date.toIso8601String(),
    };
  }

  Rating toEntity() {
    return Rating(
      id: id,
      profile: profile, // Return Profile object
      vehicleId: vehicleId,
      cleanliness: cleanliness,
      maintenance: maintenance,
      communication: communication,
      overallRating: overallRating,
      comment: comment,
      date: date,
    );
  }
}

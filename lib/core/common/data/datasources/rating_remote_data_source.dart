import 'package:car_rent/core/common/data/models/rating_model.dart';
import 'package:car_rent/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class RatingRemoteDataSource {
  Future<void> createRating(AverageRatingModel rating);
  Future<List<RatingModel>> getRatings();
  Future<List<RatingModel>> getRatingsByVehicleId(int vehicleId);
  Future<List<RatingModel>> getRatingsByProfileId(String profileId);
  Future<AverageRatingModel> getAverageRatingByVehicleId(int vehicleId);
}

class RatingRemoteDataSourceImpl implements RatingRemoteDataSource {
  final SupabaseClient supabaseClient;

  RatingRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<void> createRating(AverageRatingModel rating) async {
    try {
      var ratingjson = rating.toJson();
      ratingjson.remove('id');

      await supabaseClient.from('ratings').insert(ratingjson);
    } catch (e) {
      if (e.toString().contains("Failed host lookup")) {
        print("Network error: Unable to resolve hostname.");
        throw const ServerException(
            "Network error: Unable to resolve hostname.");
      }
      print("create failure:${e.toString()}");
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<RatingModel>> getRatings() async {
    try {
      final response =
          await supabaseClient.from('ratings').select('*, profile(*)');
      print("RatingModelgetRatings: ${response}");
      return (response as List)
          .map((data) => RatingModel.fromJson(data as Map<String, dynamic>))
          .toList();
    } catch (e) {
      if (e.toString().contains("Failed host lookup")) {
        print("Network error: Unable to resolve hostname.");
        throw const ServerException(
            "Network error: Unable to resolve hostname.");
      }
      print("getratings failure:${e.toString()}");
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<RatingModel>> getRatingsByVehicleId(int vehicleId) async {
    try {
      final response = await supabaseClient
          .from('ratings')
          .select('*, profile(*)')
          .eq('vehicle', vehicleId);
      return (response as List)
          .map((data) => RatingModel.fromJson(data as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<RatingModel>> getRatingsByProfileId(String profileId) async {
    try {
      final response = await supabaseClient
          .from('ratings')
          .select()
          .eq('profile', profileId);
      return (response as List)
          .map((data) => RatingModel.fromJson(data as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<AverageRatingModel> getAverageRatingByVehicleId(int vehicleId) async {
    try {
      final response = await supabaseClient
          .from('ratings')
          .select('cleanliness, maintenance, communication, overall_rating')
          .eq('vehicle', vehicleId);

      final ratings = (response as List)
          .map((data) => data as Map<String, dynamic>)
          .toList();

      if (ratings.isEmpty) {
        throw Exception("No ratings found for vehicle ID $vehicleId");
      }

      final avgCleanliness =
          ratings.map((r) => r['cleanliness'] as int).reduce((a, b) => a + b) /
              ratings.length;
      final avgMaintenance =
          ratings.map((r) => r['maintenance'] as int).reduce((a, b) => a + b) /
              ratings.length;
      final avgCommunication = ratings
              .map((r) => r['communication'] as int)
              .reduce((a, b) => a + b) /
          ratings.length;
      final avgOverallRating = ratings
              .map((r) => (r['overall_rating'] as num).toDouble())
              .reduce((a, b) => a + b) /
          ratings.length;

      return AverageRatingModel(
        id: ratings.length, // Placeholder ID as this is an aggregate rating
        profileId: "", // No specific profile associated with the average rating
        vehicleId: vehicleId,
        cleanliness:
            avgCleanliness.round(), // Convert back to int for consistency
        maintenance: avgMaintenance.round(),
        communication: avgCommunication.round(),
        overallRating: avgOverallRating,
        comment: "", // No specific comment for an average rating
        date: DateTime.now(), // Current date or can be adjusted
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}

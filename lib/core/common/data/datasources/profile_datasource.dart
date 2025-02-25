// datasource/profile_datasource.dart
import 'package:car_rent/core/common/data/models/profile_model.dart';
import 'package:car_rent/core/common/entities/profile.dart';
import 'package:car_rent/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ProfileRemoteDataSource {
  Future<Profile> getProfile(String id);
  Future<void> updateProfile(ProfileModel profile);
  // Future<void> addFavorite(String profileId, String favoriteId);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final SupabaseClient supabaseClient;

  ProfileRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<ProfileModel> getProfile(String id) async {
    try {
      final response =
          await supabaseClient.from('profiles').select().eq('id', id).single();
      return ProfileModel.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      if (e.toString().contains("Failed host lookup")) {
        print("Network error: Unable to resolve hostname.");
        throw const ServerException(
            "Network error: Unable to resolve hostname.");
      }
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> updateProfile(ProfileModel profile) async {
    print("profileupdatedata: ${profile}");
    try {
      await supabaseClient
          .from('profiles')
          .update(profile.toJson())
          .eq('id', profile.id);
    } catch (e) {
      if (e.toString().contains("Failed host lookup")) {
        print("Network error: Unable to resolve hostname.");
        throw const ServerException(
            "Network error: Unable to resolve hostname.");
      }
      throw ServerException(e.toString());
    }
  }
}

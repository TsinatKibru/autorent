import 'dart:io';

import 'package:car_rent/core/error/exceptions.dart';
import 'package:car_rent/features/auth/data/models/user_model.dart';
import 'package:car_rent/features/auth/domain/repository/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Session? get currentUserSession;
  Future<UserModel> signUpWithEmailPassword(
      {required String name, required String email, required String password});

  Future<UserModel> signInWithEmailPassword(
      {required String email, required String password});
  Future<UserModel?> getCurrentUserData();
  Future<void> signOut(); // Add this
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  AuthRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<UserModel> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      //print(response.user!.id);
      if (response.user == null) {
        throw const ServerException('User is null');
      }
      return UserModel.fromJson(response.user!.toJson());
    } on AuthException catch (e) {
      // Check if the error message contains network-related issues
      if (e.message.contains("Failed host lookup") ||
          e.message.contains("SocketException") ||
          e.message.contains("No address associated with hostname")) {
        //print("Network error: No internet connection.");
        throw const ServerException("Network error: No internet connection.");
      }

      // Handle generic authentication errors (e.g., wrong credentials)
      //print("Auth error: ${e.message}");
      throw ServerException("Authentication failed: ${e.message}");
    } catch (e) {
      print(e.toString());
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      //print("remote datatsource");
      final response = await supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {'name': name},
      );
      //print(response.user!.id);
      if (response.user == null) {
        //print("null response");
        throw const ServerException('User is null');
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      if (e.toString().contains("Failed host lookup")) {
        print("Network error: Unable to resolve hostname.");
        throw const ServerException(
            "Network error: Unable to resolve hostname.");
      }
      print(e.toString());
      throw ServerException(e.toString());
    }
  }

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentUserSession != null) {
        final userData = await supabaseClient
            .from('profiles')
            .select()
            .eq('id', currentUserSession!.user.id)
            .single();

        return UserModel.fromJson(userData).copyWith(
          email: currentUserSession!.user.email,
        );
      } else {
        return null;
      }
    } catch (e) {
      if (e.toString().contains("Failed host lookup")) {
        print("Network error: Unable to resolve hostname.");
        throw const ServerException(
            "Network error: Unable to resolve hostname.");
      }
      print("Error fetching current user data: $e");
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await supabaseClient.auth.signOut();
      //print("User signed out successfully");
    } catch (e) {
      if (e.toString().contains("Failed host lookup")) {
        print("Network error: Unable to resolve hostname.");
        throw const ServerException(
            "Network error: Unable to resolve hostname.");
      }
      print("Error during sign-out: $e");
      throw ServerException(e.toString());
    }
  }
}

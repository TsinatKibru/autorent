import 'package:car_rent/core/error/exceptions.dart';
import 'package:car_rent/core/error/failure.dart';
import 'package:car_rent/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:car_rent/core/common/entities/user.dart';
import 'package:car_rent/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);
  @override
  Future<Either<Failure, User>> loginWithEmailPassword(
      {required String email, required String password}) async {
    try {
      final user = await remoteDataSource.signInWithEmailPassword(
        email: email,
        password: password,
      );
      return right(user);
    } on sb.AuthException catch (e) {
      return left(Failure(e.message));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final user = await remoteDataSource.signUpWithEmailPassword(
        email: email,
        password: password,
        name: name,
      );
      return right(user);
    } on sb.AuthException catch (e) {
      return left(Failure(e.message));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      final user = await remoteDataSource.getCurrentUserData();
      if (user == null) {
        return left(Failure('User not logged In'));
      }
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await remoteDataSource.signOut();
      return right(null); // Return success
    } catch (e) {
      return left(Failure(e.toString())); // Handle failure
    }
  }
}

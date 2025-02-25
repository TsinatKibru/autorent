import 'package:car_rent/core/common/data/datasources/wallets_remote_data_source.dart';
import 'package:car_rent/core/common/domain/repository/wallets_repository.dart';
import 'package:car_rent/core/common/entities/wallet.dart';
import 'package:car_rent/core/error/exceptions.dart';
import 'package:car_rent/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

class WalletsRepositoryImpl implements WalletsRepository {
  final WalletsRemoteDataSource remoteDataSource;

  WalletsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, Wallet>> getWalletByProfileId(String profileId) async {
    try {
      final wallet = await remoteDataSource.getWalletByProfileId(profileId);
      return right(wallet);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateWalletBalance(
      String profileId, double newBalance, String type, double change) async {
    try {
      await remoteDataSource.updateWalletBalance(
          profileId, newBalance, type, change);
      return right(unit);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> addTransaction(
      String profileId, Map<String, dynamic> transaction) async {
    try {
      await remoteDataSource.addTransaction(profileId, transaction);
      return right(unit);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> createWallet(
      String profileId, double initialBalance) async {
    try {
      await remoteDataSource.createWallet(profileId, initialBalance);
      return right(unit);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}

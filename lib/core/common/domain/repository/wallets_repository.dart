import 'package:car_rent/core/common/entities/wallet.dart';
import 'package:car_rent/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class WalletsRepository {
  Future<Either<Failure, Wallet>> getWalletByProfileId(String profileId);
  Future<Either<Failure, Unit>> updateWalletBalance(
      String profileId, double newBalance, String type, double change);
  Future<Either<Failure, Unit>> addTransaction(
      String profileId, Map<String, dynamic> transaction);

  Future<Either<Failure, Unit>> createWallet(
      String profileId, double initialBalance);
}

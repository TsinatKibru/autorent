import 'package:car_rent/core/common/domain/repository/wallets_repository.dart';
import 'package:car_rent/core/common/entities/wallet.dart';
import 'package:car_rent/core/error/failure.dart';
import 'package:car_rent/core/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';

class GetWalletByProfileId implements Usecase<Wallet, String> {
  final WalletsRepository repository;

  GetWalletByProfileId(this.repository);

  @override
  Future<Either<Failure, Wallet>> call(String profileId) async {
    return await repository.getWalletByProfileId(profileId);
  }
}

class UpdateWalletBalance implements Usecase<Unit, UpdateWalletBalanceParams> {
  final WalletsRepository repository;

  UpdateWalletBalance(this.repository);

  @override
  Future<Either<Failure, Unit>> call(UpdateWalletBalanceParams params) async {
    return await repository.updateWalletBalance(
        params.profileId, params.newBalance, params.type, params.change);
  }
}

class AddTransaction implements Usecase<Unit, AddTransactionParams> {
  final WalletsRepository repository;

  AddTransaction(this.repository);

  @override
  Future<Either<Failure, Unit>> call(AddTransactionParams params) async {
    return await repository.addTransaction(
        params.profileId, params.transaction);
  }
}

class CreateWallet implements Usecase<Unit, CreateWalletParams> {
  final WalletsRepository repository;

  CreateWallet(this.repository);

  @override
  Future<Either<Failure, Unit>> call(CreateWalletParams params) async {
    return await repository.createWallet(
        params.profileId, params.initialBalance);
  }
}

class UpdateWalletBalanceParams {
  final String profileId;
  final double newBalance;
  final String type;
  final double change;

  UpdateWalletBalanceParams(
      this.profileId, this.newBalance, this.type, this.change);
}

class AddTransactionParams {
  final String profileId;
  final Map<String, dynamic> transaction;

  AddTransactionParams(this.profileId, this.transaction);
}

class CreateWalletParams {
  final String profileId;
  final double initialBalance;

  CreateWalletParams(this.profileId, this.initialBalance);
}

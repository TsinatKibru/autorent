import 'package:car_rent/core/common/domain/repository/transaction_repositories.dart';
import 'package:car_rent/core/common/entities/transaction.dart';
import 'package:car_rent/core/error/failure.dart';
import 'package:car_rent/core/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';

class FetchTransactions implements Usecase<List<Transaction>, NoParams> {
  final TransactionRepository repository;

  FetchTransactions(this.repository);

  @override
  Future<Either<Failure, List<Transaction>>> call(NoParams params) async {
    return await repository.fetchTransactions();
  }
}

class CreateTransaction implements Usecase<Unit, Transaction> {
  final TransactionRepository repository;

  CreateTransaction(this.repository);

  @override
  Future<Either<Failure, Unit>> call(Transaction transaction) async {
    return await repository.createTransaction(transaction);
  }
}

class UpdateTransaction implements Usecase<Unit, UpdateTransactionParams> {
  final TransactionRepository repository;

  UpdateTransaction(this.repository);

  @override
  Future<Either<Failure, Unit>> call(UpdateTransactionParams params) async {
    return await repository.updateTransaction(params.id, params.transaction);
  }
}

class DeleteTransaction implements Usecase<Unit, int> {
  final TransactionRepository repository;

  DeleteTransaction(this.repository);

  @override
  Future<Either<Failure, Unit>> call(int id) async {
    return await repository.deleteTransaction(id);
  }
}

class GetTransactionsByWalletId implements Usecase<List<Transaction>, int> {
  final TransactionRepository repository;

  GetTransactionsByWalletId(this.repository);

  @override
  Future<Either<Failure, List<Transaction>>> call(int walletId) async {
    return await repository.getTransactionsByWalletId(walletId);
  }
}

class UpdateTransactionParams {
  final int id;
  final Transaction transaction;

  UpdateTransactionParams(this.id, this.transaction);
}

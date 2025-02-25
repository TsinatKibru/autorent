import 'package:car_rent/core/common/data/datasources/transaction_remote_data_source.dart';
import 'package:car_rent/core/common/data/models/transaction_model.dart';
import 'package:car_rent/core/common/domain/repository/transaction_repositories.dart';
import 'package:car_rent/core/common/entities/transaction.dart';
import 'package:car_rent/core/error/exceptions.dart';
import 'package:car_rent/core/error/failure.dart';

import 'package:fpdart/fpdart.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionRemoteDataSource remoteDataSource;

  TransactionRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Transaction>>> fetchTransactions() async {
    try {
      final transactions = await remoteDataSource.fetchTransactions();
      return right(transactions);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Transaction>> getTransactionById(int id) async {
    try {
      final transaction = await remoteDataSource.getTransactionById(id);
      return right(transaction.toEntity());
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> createTransaction(
      Transaction transaction) async {
    try {
      final transactionModel = TransactionModel(
        id: transaction.id,
        walletId: transaction.walletId,
        type: transaction.type,
        amount: transaction.amount,
        timestamp: transaction.timestamp,
      );
      await remoteDataSource.createTransaction(transactionModel);
      return right(unit);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateTransaction(
      int id, Transaction transaction) async {
    try {
      final transactionModel = TransactionModel(
        id: transaction.id,
        walletId: transaction.walletId,
        type: transaction.type,
        amount: transaction.amount,
        timestamp: transaction.timestamp,
      );
      await remoteDataSource.updateTransaction(id, transactionModel);
      return right(unit);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteTransaction(int id) async {
    try {
      await remoteDataSource.deleteTransaction(id);
      return right(unit);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Transaction>>> getTransactionsByWalletId(
      int walletId) async {
    try {
      final transactions =
          await remoteDataSource.getTransactionsByWalletId(walletId);
      return right(transactions);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}

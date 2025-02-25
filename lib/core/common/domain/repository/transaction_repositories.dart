import 'package:car_rent/core/common/entities/transaction.dart';
import 'package:car_rent/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class TransactionRepository {
  Future<Either<Failure, List<Transaction>>> fetchTransactions();
  Future<Either<Failure, Transaction>> getTransactionById(int id);
  Future<Either<Failure, Unit>> createTransaction(Transaction transaction);
  Future<Either<Failure, Unit>> updateTransaction(
      int id, Transaction transaction);
  Future<Either<Failure, Unit>> deleteTransaction(int id);
  Future<Either<Failure, List<Transaction>>> getTransactionsByWalletId(
      int walletId); // New method
}

part of 'transaction_bloc.dart';

@immutable
abstract class TransactionState {}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionLoadSuccess extends TransactionState {
  final List<Transaction> transactions;
  TransactionLoadSuccess(this.transactions);
}

class TransactionFailure extends TransactionState {
  final String message;
  TransactionFailure(this.message);
}

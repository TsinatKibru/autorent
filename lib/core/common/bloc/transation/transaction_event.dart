part of 'transaction_bloc.dart';

@immutable
abstract class TransactionEvent {}

class FetchTransactionsEvent extends TransactionEvent {}

class CreateTransactionEvent extends TransactionEvent {
  final Transaction transaction;
  CreateTransactionEvent(this.transaction);
}

class UpdateTransactionEvent extends TransactionEvent {
  final int id;
  final Transaction transaction;
  UpdateTransactionEvent(this.id, this.transaction);
}

class DeleteTransactionEvent extends TransactionEvent {
  final int id;
  DeleteTransactionEvent(this.id);
}

class GetTransactionsByWalletIdEvent extends TransactionEvent {
  final int walletId;
  GetTransactionsByWalletIdEvent(this.walletId);
}

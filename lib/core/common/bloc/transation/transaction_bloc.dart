import 'package:bloc/bloc.dart';
import 'package:car_rent/core/common/domain/usecases/transaction_usecases.dart';
import 'package:car_rent/core/common/entities/transaction.dart';
import 'package:car_rent/core/usecase/usecase.dart';

import 'package:meta/meta.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final FetchTransactions _fetchTransactions;
  final CreateTransaction _createTransaction;
  final UpdateTransaction _updateTransaction;
  final DeleteTransaction _deleteTransaction;
  final GetTransactionsByWalletId _getTransactionsByWalletId; // New use case

  TransactionBloc({
    required FetchTransactions fetchTransactions,
    required CreateTransaction createTransaction,
    required UpdateTransaction updateTransaction,
    required DeleteTransaction deleteTransaction,
    required GetTransactionsByWalletId
        getTransactionsByWalletId, // New use case
  })  : _fetchTransactions = fetchTransactions,
        _createTransaction = createTransaction,
        _updateTransaction = updateTransaction,
        _deleteTransaction = deleteTransaction,
        _getTransactionsByWalletId = getTransactionsByWalletId,
        super(TransactionInitial()) {
    on<FetchTransactionsEvent>(_onFetchTransactions);
    on<CreateTransactionEvent>(_onCreateTransaction);
    on<UpdateTransactionEvent>(_onUpdateTransaction);
    on<DeleteTransactionEvent>(_onDeleteTransaction);
    on<GetTransactionsByWalletIdEvent>(_onGetTransactionsByWalletId);
  }

  void _onFetchTransactions(
      FetchTransactionsEvent event, Emitter<TransactionState> emit) async {
    emit(TransactionLoading());
    final res = await _fetchTransactions(NoParams());
    res.fold(
      (failure) => emit(TransactionFailure(failure.message)),
      (transactions) => emit(TransactionLoadSuccess(transactions)),
    );
  }

  void _onCreateTransaction(
      CreateTransactionEvent event, Emitter<TransactionState> emit) async {
    emit(TransactionLoading());
    final res = await _createTransaction(event.transaction);
    res.fold(
      (failure) => emit(TransactionFailure(failure.message)),
      (_) => add(FetchTransactionsEvent()),
    );
  }

  void _onUpdateTransaction(
      UpdateTransactionEvent event, Emitter<TransactionState> emit) async {
    emit(TransactionLoading());
    final res = await _updateTransaction(UpdateTransactionParams(
      event.id,
      event.transaction,
    ));
    res.fold(
      (failure) => emit(TransactionFailure(failure.message)),
      (_) => add(FetchTransactionsEvent()),
    );
  }

  void _onDeleteTransaction(
      DeleteTransactionEvent event, Emitter<TransactionState> emit) async {
    emit(TransactionLoading());
    final res = await _deleteTransaction(event.id);
    res.fold(
      (failure) => emit(TransactionFailure(failure.message)),
      (_) => add(FetchTransactionsEvent()),
    );
  }

  void _onGetTransactionsByWalletId(GetTransactionsByWalletIdEvent event,
      Emitter<TransactionState> emit) async {
    emit(TransactionLoading());
    final res = await _getTransactionsByWalletId(event.walletId);
    res.fold(
      (failure) => emit(TransactionFailure(failure.message)),
      (transactions) => emit(TransactionLoadSuccess(transactions)),
    );
  }
}

import 'package:car_rent/core/common/bloc/wallet/wallet_event.dart';
import 'package:car_rent/core/common/bloc/wallet/wallet_state.dart';
import 'package:car_rent/core/common/domain/usecases/wallets_usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final GetWalletByProfileId _getWalletByProfileId;
  final UpdateWalletBalance _updateWalletBalance;
  final AddTransaction _addTransaction;
  final CreateWallet _createWallet;

  WalletBloc({
    required GetWalletByProfileId getWalletByProfileId,
    required UpdateWalletBalance updateWalletBalance,
    required AddTransaction addTransaction,
    required CreateWallet createWallet,
  })  : _getWalletByProfileId = getWalletByProfileId,
        _updateWalletBalance = updateWalletBalance,
        _addTransaction = addTransaction,
        _createWallet = createWallet,
        super(WalletInitial()) {
    on<FetchWalletEvent>(_onFetchWallet);
    on<UpdateWalletBalanceEvent>(_onUpdateWalletBalance);
    on<AddTransactionEvent>(_onAddTransaction);
    on<CreateWalletEvent>(_onCreateWallet);
  }

  void _onFetchWallet(FetchWalletEvent event, Emitter<WalletState> emit) async {
    emit(WalletLoading());
    final res = await _getWalletByProfileId(event.profileId);
    res.fold(
      (failure) {
        print("Error Wallet: ${failure.message}");
        emit(WalletFailure(failure.message));
      },
      (wallet) {
        // Print the wallet details
        // print("Fetched Wallet: $wallet");
        emit(WalletLoadSuccess(wallet));
      },
    );
  }

  void _onUpdateWalletBalance(
      UpdateWalletBalanceEvent event, Emitter<WalletState> emit) async {
    emit(WalletLoading());
    final res = await _updateWalletBalance(UpdateWalletBalanceParams(
        event.profileId, event.newBalance, event.type, event.change));
    res.fold(
      (failure) => emit(WalletFailure(failure.message)),
      (_) => add(FetchWalletEvent(event.profileId)),
    );
  }

  // void _onAddTransaction(
  //     AddTransactionEvent event, Emitter<WalletState> emit) async {
  //   emit(WalletLoading());
  //   final res = await _addTransaction(

  void _onAddTransaction(
      AddTransactionEvent event, Emitter<WalletState> emit) async {
    emit(WalletLoading());

    // Call the AddTransaction use case
    final res = await _addTransaction(
      AddTransactionParams(event.profileId, event.transaction),
    );

    // Handle the result
    res.fold(
      (failure) => emit(WalletFailure(
          failure.message)), // Emit failure state if the operation fails
      (_) => add(FetchWalletEvent(event
          .profileId)), // Refresh the wallet data after adding the transaction
    );
  }

  void _onCreateWallet(
      CreateWalletEvent event, Emitter<WalletState> emit) async {
    emit(WalletLoading());

    // Call the AddTransaction use case
    final res = await _createWallet(
      CreateWalletParams(event.profileId, event.initialBalance),
    );

    // Handle the result
    res.fold(
      (failure) => emit(WalletFailure(
          failure.message)), // Emit failure state if the operation fails
      (_) => add(FetchWalletEvent(event
          .profileId)), // Refresh the wallet data after adding the transaction
    );
  }
}

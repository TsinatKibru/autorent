import 'package:car_rent/core/common/entities/wallet.dart';
import 'package:flutter/material.dart';

@immutable
abstract class WalletState {}

class WalletInitial extends WalletState {}

class WalletLoading extends WalletState {}

class WalletLoadSuccess extends WalletState {
  final Wallet wallet;
  WalletLoadSuccess(this.wallet);
}

class WalletFailure extends WalletState {
  final String message;
  WalletFailure(this.message);
}

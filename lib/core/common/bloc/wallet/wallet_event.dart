import 'package:flutter/material.dart';

@immutable
abstract class WalletEvent {}

class FetchWalletEvent extends WalletEvent {
  final String profileId;
  FetchWalletEvent(this.profileId);
}

class UpdateWalletBalanceEvent extends WalletEvent {
  final String profileId;
  final double newBalance;
  final String type;
  final double change;
  UpdateWalletBalanceEvent(
      this.profileId, this.newBalance, this.type, this.change);
}

class AddTransactionEvent extends WalletEvent {
  final String profileId;
  final Map<String, dynamic> transaction;
  AddTransactionEvent(this.profileId, this.transaction);
}

class CreateWalletEvent extends WalletEvent {
  final String profileId;
  final double initialBalance;
  CreateWalletEvent(this.profileId, this.initialBalance);
}

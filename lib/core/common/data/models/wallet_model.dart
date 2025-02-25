import 'package:car_rent/core/common/entities/wallet.dart';

class WalletModel extends Wallet {
  WalletModel({
    required int id,
    required String profileId,
    required double balance,
    required List<Map<String, dynamic>> transactions,
  }) : super(
          id: id,
          profileId: profileId,
          balance: balance,
          transactions: transactions,
        );

  factory WalletModel.fromJson(Map<String, dynamic> map) {
    return WalletModel(
      id: map['id'],
      profileId: map['profile'],
      balance: (map['balance'] as num).toDouble(),
      transactions: List<Map<String, dynamic>>.from(map['transactions'] ?? []),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return super.toJson();
  }
}

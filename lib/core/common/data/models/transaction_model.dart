import 'package:car_rent/core/common/entities/transaction.dart';

class TransactionModel extends Transaction {
  TransactionModel({
    required super.id,
    required super.walletId,
    required super.type,
    required super.amount,
    required super.timestamp,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      walletId: map['wallet_id'],
      type: map['type'],
      amount: (map['amount'] as num).toDouble(),
      timestamp: DateTime.parse(map['timestamp']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'wallet_id': walletId,
      'type': type,
      'amount': amount,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  Transaction toEntity() {
    return Transaction(
      id: id,
      walletId: walletId,
      type: type,
      amount: amount,
      timestamp: timestamp,
    );
  }
}

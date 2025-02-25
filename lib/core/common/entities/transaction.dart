class Transaction {
  final int id;
  final int walletId;
  final String type;
  final double amount;
  final DateTime timestamp;

  Transaction({
    required this.id,
    required this.walletId,
    required this.type,
    required this.amount,
    required this.timestamp,
  });

  factory Transaction.fromJson(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'],
      walletId: map['wallet_id'],
      type: map['type'],
      amount: (map['amount'] as num).toDouble(),
      timestamp: DateTime.parse(map['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'wallet_id': walletId,
      'type': type,
      'amount': amount,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'Transaction(id: $id, walletId: $walletId, type: $type, amount: $amount, timestamp: $timestamp)';
  }
}

class Wallet {
  final int id;
  final String profileId;
  final double balance;
  final List<Map<String, dynamic>> transactions;

  Wallet({
    required this.id,
    required this.profileId,
    required this.balance,
    required this.transactions,
  });

  factory Wallet.fromJson(Map<String, dynamic> map) {
    return Wallet(
      id: map['id'],
      profileId: map['profile'],
      balance: (map['balance'] as num).toDouble(),
      transactions: List<Map<String, dynamic>>.from(map['transactions'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profile': profileId,
      'balance': balance,
      'transactions': transactions,
    };
  }

  @override
  String toString() {
    return 'Wallet(id: $id, profileId: $profileId, balance: $balance, transactions: $transactions)';
  }
}

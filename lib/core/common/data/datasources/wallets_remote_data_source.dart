import 'package:car_rent/core/common/data/models/wallet_model.dart';
import 'package:car_rent/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class WalletsRemoteDataSource {
  Future<WalletModel> getWalletByProfileId(String profileId);
  Future<void> updateWalletBalance(
      String profileId, double newBalance, String type, double change);
  Future<void> addTransaction(
      String profileId, Map<String, dynamic> transaction);
  Future<void> createWallet(
      String profileId, double initialBalance); // New method
}

class WalletsRemoteDataSourceImpl implements WalletsRemoteDataSource {
  final SupabaseClient supabaseClient;

  WalletsRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<WalletModel> getWalletByProfileId(String profileId) async {
    try {
      final response = await supabaseClient
          .from('wallets')
          .select()
          .eq('profile', profileId)
          .single();
      print(response);
      return WalletModel.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      if (e.toString().contains("Failed host lookup")) {
        print("Network error: Unable to resolve hostname.");
        throw const ServerException(
            "Network error: Unable to resolve hostname.");
      }
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> updateWalletBalance(
      String profileId, double newBalance, String type, double change) async {
    try {
      // Call the PostgreSQL function using Supabase's rpc method
      await supabaseClient.rpc('update_wallet_and_add_transaction', params: {
        'profile_id': profileId,
        'new_balance': newBalance,
        'transaction_type': type,
        'transaction_amount': change,
      });
    } catch (e) {
      if (e.toString().contains("Failed host lookup")) {
        print("Network error: Unable to resolve hostname.");
        throw const ServerException(
            "Network error: Unable to resolve hostname.");
      }
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> addTransaction(
      String profileId, Map<String, dynamic> transaction) async {
    try {
      await supabaseClient.from('wallets').update({
        'transactions': transaction,
      }).eq('profile', profileId);
    } catch (e) {
      if (e.toString().contains("Failed host lookup")) {
        print("Network error: Unable to resolve hostname.");
        throw const ServerException(
            "Network error: Unable to resolve hostname.");
      }
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> createWallet(String profileId, double initialBalance) async {
    try {
      // Insert a new wallet with the given profile ID and initial balance
      await supabaseClient.from('wallets').insert({
        'profile': profileId,
        'balance': initialBalance,
        'transactions': [], // Initialize with an empty list of transactions
      });
    } catch (e) {
      if (e.toString().contains("Failed host lookup")) {
        print("Network error: Unable to resolve hostname.");
        throw const ServerException(
            "Network error: Unable to resolve hostname.");
      }
      throw ServerException(e.toString());
    }
  }
}

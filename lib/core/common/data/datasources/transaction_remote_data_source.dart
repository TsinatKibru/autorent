import 'package:car_rent/core/common/data/models/transaction_model.dart';
import 'package:car_rent/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class TransactionRemoteDataSource {
  Future<List<TransactionModel>> fetchTransactions();
  Future<TransactionModel> getTransactionById(int id);
  Future<void> createTransaction(TransactionModel transaction);
  Future<void> updateTransaction(int id, TransactionModel transaction);
  Future<void> deleteTransaction(int id);
  Future<List<TransactionModel>> getTransactionsByWalletId(
      int walletId); // New method
}

class TransactionRemoteDataSourceImpl implements TransactionRemoteDataSource {
  final SupabaseClient supabaseClient;

  TransactionRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<List<TransactionModel>> fetchTransactions() async {
    try {
      final response = await supabaseClient.from('transactions').select();
      return (response as List<dynamic>)
          .map((transaction) =>
              TransactionModel.fromJson(transaction as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<TransactionModel> getTransactionById(int id) async {
    try {
      final response = await supabaseClient
          .from('transactions')
          .select()
          .eq('id', id)
          .single();
      return TransactionModel.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> createTransaction(TransactionModel transaction) async {
    try {
      await supabaseClient.from('transactions').insert(transaction.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> updateTransaction(int id, TransactionModel transaction) async {
    try {
      await supabaseClient
          .from('transactions')
          .update(transaction.toJson())
          .eq('id', id);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> deleteTransaction(int id) async {
    try {
      await supabaseClient.from('transactions').delete().eq('id', id);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<TransactionModel>> getTransactionsByWalletId(int walletId) async {
    try {
      final response = await supabaseClient
          .from('transactions')
          .select()
          .eq('wallet_id', walletId)
          .order('timestamp', ascending: false); // Sorting in ascending order

      return (response as List<dynamic>)
          .map((transaction) =>
              TransactionModel.fromJson(transaction as Map<String, dynamic>))
          .toList();
      // final response = await supabaseClient
      //     .from('transactions')
      //     .select()
      //     .eq('wallet_id', walletId);
      // return (response as List<dynamic>)
      //     .map((transaction) =>
      //         TransactionModel.fromJson(transaction as Map<String, dynamic>))
      //     .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}

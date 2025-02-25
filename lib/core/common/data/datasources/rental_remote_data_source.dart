import 'package:car_rent/core/common/data/models/rental_model.dart';
import 'package:car_rent/core/error/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class RentalRemoteDataSource {
  Future<void> createRental(RentalModel rental);
  Future<void> updateRentalStatus(int rentalId, String status);
  Future<List<RentalModel>> getRentals();
}

class RentalRemoteDataSourceImpl implements RentalRemoteDataSource {
  final SupabaseClient supabaseClient;

  RentalRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<void> createRental(RentalModel rental) async {
    try {
      var rentaljson = rental.toJson();
      rentaljson.remove('id');

      await supabaseClient.from('rentals').insert(rentaljson);
    } catch (e) {
      if (e.toString().contains("Failed host lookup")) {
        throw const ServerException(
            "Network error: Unable to resolve hostname.");
      }
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> updateRentalStatus(int rentalId, String status) async {
    try {
      await supabaseClient
          .from('rentals')
          .update({'status': status}).eq('id', rentalId);
    } catch (e) {
      if (e.toString().contains("Failed host lookup")) {
        throw const ServerException(
            "Network error: Unable to resolve hostname.");
      }
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<RentalModel>> getRentals() async {
    try {
      final response = await supabaseClient.from('rentals').select();
      return (response as List)
          .map((data) => RentalModel.fromJson(data as Map<String, dynamic>))
          .toList();
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

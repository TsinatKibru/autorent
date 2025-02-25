import 'dart:io';

import 'package:car_rent/core/error/exceptions.dart';
import 'package:car_rent/features/car/data/models/vehicle_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class VehiclesRemoteDataSource {
  Future<List<VehicleModel>> fetchVehicles(
      {required int page, required int limit});
  Future<List<VehicleModel>> fetchTopRatedVehicles({required int limit});
  Future<List<VehicleModel>> fetchFavoriteVehicles(List<int> ids);

  Future<VehicleModel> getVehicleById(int id);
  Future<List<VehicleModel>> getVehiclesByHostId(String id);
  Future<void> createVehicle(VehicleModel vehicle);
  Future<VehicleModel> updateVehicle(int id, VehicleModel vehicle);
  Future<void> deleteVehicle(int id);
  Future<List<VehicleModel>> searchVehicles(
      {required String keyword, required int page, required int limit});
}

class VehiclesRemoteDataSourceImpl implements VehiclesRemoteDataSource {
  final SupabaseClient supabaseClient;

  VehiclesRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<List<VehicleModel>> fetchVehicles(
      {required int page, required int limit}) async {
    try {
      final response = await supabaseClient
          .from('vehicles')
          .select()
          .eq('active_status', true)
          .range((page - 1) * limit, (page * limit) - 1);

      return (response as List<dynamic>)
          .map((vehicle) =>
              VehicleModel.fromJson(vehicle as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<VehicleModel>> fetchTopRatedVehicles({required int limit}) async {
    try {
      final response = await supabaseClient
          .from('vehicles')
          .select()
          .eq('active_status', true)
          .order('rating', ascending: false)
          .limit(limit);

      // return (response as List<dynamic>)
      //     .map((vehicle) =>
      //         VehicleModel.fromJson(vehicle as Map<String, dynamic>))
      //     .toList();
      final vehicles = (response as List<dynamic>)
          .map((vehicle) =>
              VehicleModel.fromJson(vehicle as Map<String, dynamic>))
          .toList();

      // Log fetched vehicle information
      // vehicles.forEach((vehicle) {
      //   print('Fetched vehicle: ${vehicle.toString()}');
      // });

      return vehicles;
    } catch (e) {
      if (e.toString().contains("Failed host lookup") ||
          e.toString().contains("no route to host")) {
        print("Network error: Unable to resolve hostname.");
        throw const ServerException(
            "Network error: Unable to resolve hostname.");
      }
      throw ServerException(e.toString());
    }
  }

  @override
  Future<VehicleModel> getVehicleById(int id) async {
    try {
      final response = await supabaseClient
          .from('vehicles')
          .select()
          .eq('id', id)
          .eq('active_status', true)
          .single();
      return VehicleModel.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<VehicleModel>> getVehiclesByHostId(String id) async {
    print("getVehiclesByHostId");
    try {
      final response = await supabaseClient
          .from('vehicles')
          .select()
          .eq('host', id)
          .eq('active_status', true);

      final List data = response as List;
      return data
          .map((vehicle) =>
              VehicleModel.fromJson(vehicle as Map<String, dynamic>))
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

  @override
  Future<void> createVehicle(VehicleModel vehicle) async {
    try {
      // Remove the 'id' field from the vehicle object if it exists
      var vehicleJson = vehicle.toJson();
      vehicleJson.remove('id');
      vehicleJson.remove('rating');

      print("Vehicle JSON (without id): $vehicleJson");

      // Insert the vehicle without the 'id' field
      await supabaseClient.from('vehicles').insert(vehicleJson);
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
  Future<VehicleModel> updateVehicle(int id, VehicleModel vehicle) async {
    print(" updateVehicle");
    try {
      final response = await supabaseClient
          .from('vehicles')
          .update(vehicle.toJson())
          .eq('id', id)
          .select()
          .single();

      return VehicleModel.fromJson(response);
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
  Future<void> deleteVehicle(int id) async {
    try {
      await supabaseClient.from('vehicles').delete().eq('id', id);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  // @override
  // Future<List<VehicleModel>> searchVehicles({
  //   required String keyword,
  //   required int page,
  //   required int limit,
  // }) async {
  //   try {
  //     final response = await supabaseClient
  //         .from('vehicles')
  //         .select()
  //         .eq('active_status', true)
  //         .or('model.ilike.%$keyword%,brand.ilike.%$keyword%,plate_number.ilike.%$keyword%')
  //         .range((page - 1) * limit, page * limit - 1); // Pagination logic

  //     return (response as List<dynamic>)
  //         .map((vehicle) =>
  //             VehicleModel.fromJson(vehicle as Map<String, dynamic>))
  //         .toList();
  //   } catch (e) {
  //     if (e.toString().contains("Failed host lookup")) {
  //       print("Network error: Unable to resolve hostname.");
  //       throw ServerException("Network error: Unable to resolve hostname.");
  //     }
  //     throw ServerException(e.toString());
  //   }
  // }
  @override
  Future<List<VehicleModel>> searchVehicles({
    required String keyword,
    required int page,
    required int limit,
  }) async {
    try {
      final startRange = (page - 1) * limit;
      final endRange = page * limit - 1;
      List<dynamic> response;

      if (keyword.startsWith("price:")) {
        // Extract price value
        String value = keyword.split(":")[1];
        double? priceValue = double.tryParse(value);

        if (priceValue == null) {
          throw ArgumentError("Invalid price value");
        }

        response = await supabaseClient
            .from('vehicles')
            .select()
            .eq('active_status', true)
            .gte('price_per_hour',
                priceValue) // Fetch where price >= given value
            .order('price_per_hour', ascending: true)
            .range(startRange, endRange);
      } else if (keyword.startsWith("speed:")) {
        // Extract speed value
        String value = keyword.split(":")[1];
        double? speedValue = double.tryParse(value);

        if (speedValue == null) {
          throw ArgumentError("Invalid speed value");
        }

        response = await supabaseClient
            .from('vehicles')
            .select()
            .eq('active_status', true)
            .gte('top_speed', speedValue) // Fetch where speed >= given value
            .order('top_speed', ascending: true)
            .range(startRange, endRange);
      } else {
        // Default search by model or brand
        response = await supabaseClient
            .from('vehicles')
            .select()
            .eq('active_status', true)
            .or('model.ilike.%$keyword%,brand.ilike.%$keyword%,plate_number.ilike.%$keyword%')
            .range(startRange, endRange);
      }

      return response
          .map((vehicle) =>
              VehicleModel.fromJson(vehicle as Map<String, dynamic>))
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

  @override
  Future<List<VehicleModel>> fetchFavoriteVehicles(List<int> ids) async {
    try {
      if (ids.isEmpty) return [];

      final response = await supabaseClient
          .from('vehicles')
          .select()
          .inFilter('id', ids)
          .eq('active_status', true);

      return (response as List<dynamic>)
          .map((vehicle) =>
              VehicleModel.fromJson(vehicle as Map<String, dynamic>))
          .toList();
    } catch (e) {
      if (e.toString().contains("Failed host lookup") ||
          e.toString().contains("no route to host")) {
        print("Network error: Unable to resolve hostname.");
        throw const ServerException(
            "Network error: Unable to resolve hostname.");
      }
      throw ServerException(e.toString());
    }
  }
}

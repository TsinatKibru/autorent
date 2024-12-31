import 'dart:io';

import 'package:car_rent/core/error/exceptions.dart';
import 'package:car_rent/features/car/data/models/uploaded_image_model.dart';
import 'package:car_rent/features/car/data/models/vehicle_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class VehiclesRemoteDataSource {
  Future<List<VehicleModel>> fetchVehicles();
  Future<VehicleModel> getVehicleById(int id);
  Future<void> createVehicle(VehicleModel vehicle);
  Future<void> updateVehicle(int id, VehicleModel vehicle);
  Future<void> deleteVehicle(int id);
}

class VehiclesRemoteDataSourceImpl implements VehiclesRemoteDataSource {
  final SupabaseClient supabaseClient;

  VehiclesRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<List<VehicleModel>> fetchVehicles() async {
    try {
      final response = await supabaseClient.from('vehicles').select();
      return (response as List<dynamic>)
          .map((vehicle) =>
              VehicleModel.fromJson(vehicle as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<VehicleModel> getVehicleById(int id) async {
    try {
      final response =
          await supabaseClient.from('vehicles').select().eq('id', id).single();
      return VehicleModel.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  // @override
  // Future<void> createVehicle(VehicleModel vehicle) async {
  //   try {
  //     await supabaseClient.from('vehicles').insert(vehicle.toJson());
  //   } catch (e) {
  //     throw ServerException(e.toString());
  //   }
  // }

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
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> updateVehicle(int id, VehicleModel vehicle) async {
    try {
      await supabaseClient
          .from('vehicles')
          .update(vehicle.toJson())
          .eq('id', id);
    } catch (e) {
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
}

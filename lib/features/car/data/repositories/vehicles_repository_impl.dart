import 'package:car_rent/core/common/entities/uploaded_image.dart';
import 'package:car_rent/core/error/exceptions.dart';
import 'package:car_rent/core/error/failure.dart';
import 'package:car_rent/features/car/data/datasources/vehicles_remote_data_source.dart';
import 'package:car_rent/features/car/data/models/vehicle_model.dart';
import 'package:car_rent/features/car/domain/entities/vehicle.dart';
import 'package:car_rent/features/car/domain/repository/vehicle_repository.dart';

import 'package:fpdart/fpdart.dart';

class VehiclesRepositoryImpl implements VehiclesRepository {
  final VehiclesRemoteDataSource remoteDataSource;

  VehiclesRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Vehicle>>> fetchVehicles(
      {required int page, required int limit}) async {
    try {
      final vehicles =
          await remoteDataSource.fetchVehicles(page: page, limit: limit);
      return right(vehicles);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Vehicle>> getVehicleById(int id) async {
    try {
      final vehicle = await remoteDataSource.getVehicleById(id);
      return right(vehicle);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> createVehicle(Vehicle vehicle) async {
    try {
      // Convert Vehicle to VehicleModel
      final vehicleModel = VehicleModel(
        id: vehicle.id,
        plateNumber: vehicle.plateNumber,
        model: vehicle.model,
        brand: vehicle.brand,
        pricePerHour: vehicle.pricePerHour,
        previousPricePerHour: vehicle.previousPricePerHour,
        descriptionNote: vehicle.descriptionNote,
        batteryCapacity: vehicle.batteryCapacity,
        topSpeed: vehicle.topSpeed,
        transmissionType: vehicle.transmissionType,
        engineOutput: vehicle.engineOutput,
        numberOfDoors: vehicle.numberOfDoors,
        insuranceImageUrl: vehicle.insuranceImageUrl,
        guidelines: vehicle.guidelines,
        category: vehicle.category,
        host: vehicle.host,
        seatingCapacity: vehicle.seatingCapacity,
        rating: vehicle.rating,
        available: vehicle.available,
        activeStatus: vehicle.activeStatus,
        gallery: vehicle.gallery,
        createdAt: vehicle.createdAt,
        updatedAt: vehicle.updatedAt,
      );

      await remoteDataSource
          .createVehicle(vehicleModel); // Pass the converted VehicleModel
      return right(unit);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Vehicle>> updateVehicle(
      int id, Vehicle vehicle) async {
    try {
      // Convert Vehicle to VehicleModel
      final vehicleModel = VehicleModel(
        id: vehicle.id,
        plateNumber: vehicle.plateNumber,
        model: vehicle.model,
        brand: vehicle.brand,
        pricePerHour: vehicle.pricePerHour,
        previousPricePerHour: vehicle.previousPricePerHour,
        descriptionNote: vehicle.descriptionNote,
        batteryCapacity: vehicle.batteryCapacity,
        topSpeed: vehicle.topSpeed,
        transmissionType: vehicle.transmissionType,
        engineOutput: vehicle.engineOutput,
        numberOfDoors: vehicle.numberOfDoors,
        insuranceImageUrl: vehicle.insuranceImageUrl,
        guidelines: vehicle.guidelines,
        category: vehicle.category,
        host: vehicle.host,
        seatingCapacity: vehicle.seatingCapacity,
        rating: vehicle.rating,
        available: vehicle.available,
        activeStatus: vehicle.activeStatus,
        gallery: vehicle.gallery,
        createdAt: vehicle.createdAt,
        updatedAt: vehicle.updatedAt,
      );

      // Call the data source and get the updated VehicleModel
      final updatedVehicleModel =
          await remoteDataSource.updateVehicle(id, vehicleModel);

      // Convert VehicleModel back to Vehicle
      final updatedVehicle = updatedVehicleModel.toEntity();

      return right(updatedVehicle);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteVehicle(int id) async {
    try {
      await remoteDataSource.deleteVehicle(id);
      return right(unit);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Vehicle>>> fetchTopRatedVehicles(
      {required int limit}) async {
    try {
      // Pass the 'limit' parameter to the remoteDataSource method
      final vehicles =
          await remoteDataSource.fetchTopRatedVehicles(limit: limit);
      return right(vehicles);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Vehicle>>> searchVehicles({
    required String query,
    required int page,
    required int limit,
  }) async {
    try {
      final vehicles = await remoteDataSource.searchVehicles(
        keyword: query,
        page: page,
        limit: limit,
      );

      return right(vehicles);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Vehicle>>> getVehiclesByHostId(String id) async {
    // TODO: implement getVehiclesByHostId
    try {
      // Pass the 'limit' parameter to the remoteDataSource method
      final vehicles = await remoteDataSource.getVehiclesByHostId(id);
      return right(vehicles);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Vehicle>>> fetchFavoriteVehicles(
      List<int> ids) async {
    try {
      final vehicles = await remoteDataSource.fetchFavoriteVehicles(ids);
      return right(vehicles);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}

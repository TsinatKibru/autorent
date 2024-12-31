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
  Future<Either<Failure, List<Vehicle>>> fetchVehicles() async {
    try {
      final vehicles = await remoteDataSource.fetchVehicles();
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
  Future<Either<Failure, Unit>> updateVehicle(int id, Vehicle vehicle) async {
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
        gallery: vehicle.gallery,
        createdAt: vehicle.createdAt,
        updatedAt: vehicle.updatedAt,
      );

      await remoteDataSource.updateVehicle(
          id, vehicleModel); // Pass the converted VehicleModel
      return right(unit);
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
}

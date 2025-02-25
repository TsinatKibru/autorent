import 'package:car_rent/core/common/data/datasources/trips_remote_data_source.dart';
import 'package:car_rent/core/common/data/models/trip_model.dart';
import 'package:car_rent/core/common/domain/repository/trip_repository.dart';
import 'package:car_rent/core/common/domain/usecases/trip.dart';
import 'package:car_rent/core/common/entities/trip.dart';
import 'package:car_rent/core/error/exceptions.dart';
import 'package:car_rent/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

class TripsRepositoryImpl implements TripsRepository {
  final TripsRemoteDataSource remoteDataSource;

  TripsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Trip>>> fetchTrips() async {
    try {
      final trips = await remoteDataSource.fetchTrips();
      return right(trips);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  // @override
  // Future<Either<Failure, List<Trip>>> fetchTripsByProfileId(
  //     String profileId, bool? host) async {
  //   try {
  //     final trips =
  //         await remoteDataSource.fetchTripsByProfileId(profileId, host);
  //     return right(trips);
  //   } on ServerException catch (e) {
  //     return left(Failure(e.message));
  //   }
  // }
  @override
  Future<Either<Failure, List<Trip>>> fetchTripsByProfileId(
      FetchTripsByProfileIdParams params) async {
    try {
      final trips = await remoteDataSource.fetchTripsByProfileId(params);
      return right(trips);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Trip>> getTripById(int id) async {
    try {
      final trip = await remoteDataSource.getTripById(id);
      return right(trip);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> createTrip(Trip trip) async {
    try {
      await remoteDataSource.createTrip(trip as TripModel);
      return right(unit);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Trip>> updateTrip(int id, String status) async {
    try {
      final updatedTripData = await remoteDataSource.updateTrip(id, status);

      return right(updatedTripData.toEntity());
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteTrip(int id) async {
    try {
      await remoteDataSource.deleteTrip(id);
      return right(unit);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Stream<void> listenForTripChanges(String profileId, bool? host) {
    return remoteDataSource.listenForTripChanges(profileId, host);
  }
}

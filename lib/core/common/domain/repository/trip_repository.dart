import 'package:car_rent/core/common/domain/usecases/trip.dart';
import 'package:car_rent/core/common/entities/trip.dart';
import 'package:car_rent/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class TripsRepository {
  Future<Either<Failure, List<Trip>>> fetchTrips();
  // Future<Either<Failure, List<Trip>>> fetchTripsByProfileId(
  //     String profileId, bool? host);
  Future<Either<Failure, List<Trip>>> fetchTripsByProfileId(
      FetchTripsByProfileIdParams params);
  Future<Either<Failure, Trip>> getTripById(int id);
  Future<Either<Failure, Unit>> createTrip(Trip trip);
  Future<Either<Failure, Trip>> updateTrip(int id, String status);
  Future<Either<Failure, Unit>> deleteTrip(int id);
  Stream<void> listenForTripChanges(String profileId, bool? host);
}

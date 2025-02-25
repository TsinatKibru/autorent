import 'package:car_rent/core/common/domain/repository/trip_repository.dart';
import 'package:car_rent/core/common/entities/trip.dart';
import 'package:car_rent/core/error/failure.dart';
import 'package:car_rent/core/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';

class FetchTrips implements Usecase<List<Trip>, NoParams> {
  final TripsRepository repository;

  FetchTrips(this.repository);

  @override
  Future<Either<Failure, List<Trip>>> call(NoParams params) async {
    return await repository.fetchTrips();
  }
}

// class FetchTripsByProfileId
//     implements Usecase<List<Trip>, FetchTripsByProfileIdParams> {
//   final TripsRepository repository;

//   FetchTripsByProfileId(this.repository);

//   @override
//   Future<Either<Failure, List<Trip>>> call(
//       FetchTripsByProfileIdParams params) async {
//     return await repository.fetchTripsByProfileId(
//          params.profileId, params.host);
//   }
// }

class FetchTripsByProfileId
    implements Usecase<List<Trip>, FetchTripsByProfileIdParams> {
  final TripsRepository repository;

  FetchTripsByProfileId(this.repository);

  @override
  Future<Either<Failure, List<Trip>>> call(
      FetchTripsByProfileIdParams params) async {
    return await repository.fetchTripsByProfileId(params);
  }
}

class UpdateTripStatus implements Usecase<Trip, UpdateTripStatusParams> {
  final TripsRepository repository;

  UpdateTripStatus(this.repository);

  @override
  Future<Either<Failure, Trip>> call(UpdateTripStatusParams params) async {
    return await repository.updateTrip(params.id, params.status);
  }
}

class ListenForTripChanges {
  final TripsRepository repository;

  ListenForTripChanges(this.repository);

  Stream<void> call(String profileId, bool? host) {
    return repository.listenForTripChanges(profileId, host);
  }
}

// class FetchTripsByProfileIdParams {
//   final String profileId;
//   final bool? host;
//   FetchTripsByProfileIdParams(this.profileId, this.host);
// }
class FetchTripsByProfileIdParams {
  final String profileId;
  final bool? host;
  final String? status;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? limit;
  final int? offset;

  FetchTripsByProfileIdParams({
    required this.profileId,
    this.host,
    this.status,
    this.startDate,
    this.endDate,
    this.limit,
    this.offset,
  });
}

class UpdateTripStatusParams {
  final String status;
  final int id;

  UpdateTripStatusParams({
    required this.status,
    required this.id,
  });
}

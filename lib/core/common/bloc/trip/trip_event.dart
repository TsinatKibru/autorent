part of 'trip_bloc.dart';

@immutable
abstract class TripEvent {}

class FetchTripsEvent extends TripEvent {}

// class FetchTripsByProfileIdEvent extends TripEvent {
//   final String profileId;
//   final bool? host;
//   FetchTripsByProfileIdEvent(this.profileId, this.host);
// }
class FetchTripsByProfileIdEvent extends TripEvent {
  final String profileId;
  final bool? host;
  final String? status;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? limit;
  final int? offset;
  final bool isLiveUpdate;

  FetchTripsByProfileIdEvent({
    required this.profileId,
    this.host,
    this.status,
    this.startDate,
    this.endDate,
    this.limit,
    this.offset,
    this.isLiveUpdate = false,
  });
}

class UpdateTripStatusEvent extends TripEvent {
  final int id;
  final String status;
  UpdateTripStatusEvent(this.id, this.status);
}

class SubscribeToTripsChangesEvent extends TripEvent {
  final String profileId;
  final bool? host;
  final String? status;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? limit;
  final int? offset;

  SubscribeToTripsChangesEvent({
    required this.profileId,
    this.host,
    this.status,
    this.startDate,
    this.endDate,
    this.limit,
    this.offset,
  });
}

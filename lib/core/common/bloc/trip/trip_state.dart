part of 'trip_bloc.dart';

@immutable
abstract class TripState {}

class TripInitial extends TripState {}

class TripLoading extends TripState {}

class TripLoadSuccess extends TripState {
  final List<Trip> trips;
  TripLoadSuccess(this.trips);
}

class TripFailure extends TripState {
  final String message;
  TripFailure(this.message);
}

class TripStatusUpdated extends TripState {
  final Trip trip;
  TripStatusUpdated(this.trip);
}

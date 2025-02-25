// part of 'rating_bloc.dart';

// @immutable
// abstract class RatingEvent {}

// class FetchRatingsEvent extends RatingEvent {}

// class CreateRatingEvent extends RatingEvent {
//   final Rating rating;
//   CreateRatingEvent(this.rating);
// }
part of 'rating_bloc.dart';

@immutable
abstract class RatingEvent {}

class FetchRatingsEvent extends RatingEvent {}

class FetchRatingsByVehicleIdEvent extends RatingEvent {
  final int vehicleId;
  FetchRatingsByVehicleIdEvent(this.vehicleId);
}

class FetchRatingsByProfileIdEvent extends RatingEvent {
  final String profileId;
  FetchRatingsByProfileIdEvent(this.profileId);
}

class FetchAverageRatingByVehicleIdEvent extends RatingEvent {
  final int vehicleId;
  FetchAverageRatingByVehicleIdEvent(this.vehicleId);
}

class CreateRatingEvent extends RatingEvent {
  final AverageRating rating;
  CreateRatingEvent(this.rating);
}

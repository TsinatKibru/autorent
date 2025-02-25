// part of 'rating_bloc.dart';

// @immutable
// abstract class RatingEvent {}

// class FetchRatingsEvent extends RatingEvent {}

// class CreateRatingEvent extends RatingEvent {
//   final Rating rating;
//   CreateRatingEvent(this.rating);
// }
part of 'average_rating_bloc.dart';

@immutable
abstract class AverageRatingEvent {}

class FetchAverageRatingByVehicleIdEvent extends AverageRatingEvent {
  final int vehicleId;
  FetchAverageRatingByVehicleIdEvent(this.vehicleId);
}

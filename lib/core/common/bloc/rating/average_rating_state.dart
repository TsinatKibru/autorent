// part of 'rating_bloc.dart';

// @immutable
// abstract class RatingState {}

// class RatingInitial extends RatingState {}

// class RatingLoading extends RatingState {}

// class RatingLoadSuccess extends RatingState {
//   final List<Rating> ratings;
//   RatingLoadSuccess(this.ratings);
// }

// class RatingFailure extends RatingState {
//   final String message;
//   RatingFailure(this.message);
// }
part of 'average_rating_bloc.dart';

@immutable
abstract class AverageRatingState {}

class AverageRatingInitial extends AverageRatingState {}

class AverageRatingLoading extends AverageRatingState {}

class AverageRatingLoadSuccess extends AverageRatingState {
  final AverageRating averageRating;
  AverageRatingLoadSuccess(this.averageRating);
}

class AverageRatingFailure extends AverageRatingState {
  final String message;
  AverageRatingFailure(this.message);
}

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
part of 'rating_bloc.dart';

@immutable
abstract class RatingState {}

class RatingInitial extends RatingState {}

class RatingLoading extends RatingState {}

class RatingLoadSuccess extends RatingState {
  final List<Rating> ratings;
  RatingLoadSuccess(this.ratings);
}

class RatingAverageLoadSuccess extends RatingState {
  final AverageRating averageRating;
  RatingAverageLoadSuccess(this.averageRating);
}

class RatingFailure extends RatingState {
  final String message;
  RatingFailure(this.message);
}

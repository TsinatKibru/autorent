import 'package:car_rent/core/common/domain/usecases/ratings_usecase.dart';
import 'package:car_rent/core/common/entities/rating.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:car_rent/core/usecase/usecase.dart';

part 'rating_event.dart';
part 'rating_state.dart';

// class RatingBloc extends Bloc<RatingEvent, RatingState> {
//   final CreateRating createRating;
//   final GetRatings getRatings;

//   RatingBloc({
//     required this.createRating,
//     required this.getRatings,
//   }) : super(RatingInitial()) {
//     on<FetchRatingsEvent>(_onFetchRatings);
//     on<CreateRatingEvent>(_onCreateRating);
//   }

//   void _onFetchRatings(
//       FetchRatingsEvent event, Emitter<RatingState> emit) async {
//     emit(RatingLoading());
//     final res = await getRatings(NoParams());
//     res.fold(
//       (failure) => emit(RatingFailure(failure.message)),
//       (ratings) => emit(RatingLoadSuccess(ratings)),
//     );
//   }

//   void _onCreateRating(
//       CreateRatingEvent event, Emitter<RatingState> emit) async {
//     emit(RatingLoading());
//     final res = await createRating(event.rating);
//     res.fold(
//       (failure) => emit(RatingFailure(failure.message)),
//       (_) => add(FetchRatingsEvent()),
//     );
//   }
// }
class RatingBloc extends Bloc<RatingEvent, RatingState> {
  final CreateRating createRating;
  final GetRatings getRatings;
  final GetRatingsByVehicleId getRatingsByVehicleId;
  final GetRatingsByProfileId getRatingsByProfileId;
  final GetAverageRatingByVehicleId getAverageRatingByVehicleId;

  RatingBloc({
    required this.createRating,
    required this.getRatings,
    required this.getRatingsByVehicleId,
    required this.getRatingsByProfileId,
    required this.getAverageRatingByVehicleId,
  }) : super(RatingInitial()) {
    on<FetchRatingsEvent>(_onFetchRatings);
    on<FetchRatingsByVehicleIdEvent>(_onFetchRatingsByVehicleId);
    on<FetchRatingsByProfileIdEvent>(_onFetchRatingsByProfileId);
    on<FetchAverageRatingByVehicleIdEvent>(_onFetchAverageRatingByVehicleId);
    on<CreateRatingEvent>(_onCreateRating);
  }

  void _onFetchRatings(
      FetchRatingsEvent event, Emitter<RatingState> emit) async {
    emit(RatingLoading());
    final res = await getRatings(NoParams());
    res.fold(
      (failure) => emit(RatingFailure(failure.message)),
      (ratings) => emit(RatingLoadSuccess(ratings)),
    );
  }

  void _onFetchRatingsByVehicleId(
      FetchRatingsByVehicleIdEvent event, Emitter<RatingState> emit) async {
    emit(RatingLoading());
    final res = await getRatingsByVehicleId(event.vehicleId);
    res.fold(
      (failure) => emit(RatingFailure(failure.message)),
      (ratings) => emit(RatingLoadSuccess(ratings)),
    );
  }

  void _onFetchRatingsByProfileId(
      FetchRatingsByProfileIdEvent event, Emitter<RatingState> emit) async {
    emit(RatingLoading());
    final res = await getRatingsByProfileId(event.profileId);
    res.fold(
      (failure) => emit(RatingFailure(failure.message)),
      (ratings) => emit(RatingLoadSuccess(ratings)),
    );
  }

  void _onFetchAverageRatingByVehicleId(
      FetchAverageRatingByVehicleIdEvent event,
      Emitter<RatingState> emit) async {
    emit(RatingLoading());
    final res = await getAverageRatingByVehicleId(event.vehicleId);
    res.fold(
      (failure) => emit(RatingFailure(failure.message)),
      (averageRating) => emit(RatingAverageLoadSuccess(averageRating)),
    );
  }

  void _onCreateRating(
      CreateRatingEvent event, Emitter<RatingState> emit) async {
    emit(RatingLoading());
    final res = await createRating(event.rating);
    res.fold(
      (failure) => emit(RatingFailure(failure.message)),
      (_) => add(FetchRatingsByVehicleIdEvent(event.rating.vehicleId)),
    );
  }
}

import 'package:car_rent/core/common/domain/usecases/ratings_usecase.dart';
import 'package:car_rent/core/common/entities/rating.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'average_rating_event.dart';
part 'average_rating_state.dart';

class AverageRatingBloc extends Bloc<AverageRatingEvent, AverageRatingState> {
  final GetAverageRatingByVehicleId getAverageRatingByVehicleId;

  AverageRatingBloc({
    required this.getAverageRatingByVehicleId,
  }) : super(AverageRatingInitial()) {
    on<FetchAverageRatingByVehicleIdEvent>(_onFetchAverageRatingByVehicleId);
  }

  void _onFetchAverageRatingByVehicleId(
      FetchAverageRatingByVehicleIdEvent event,
      Emitter<AverageRatingState> emit) async {
    emit(AverageRatingLoading());
    final res = await getAverageRatingByVehicleId(event.vehicleId);
    res.fold(
      (failure) => emit(AverageRatingFailure(failure.message)),
      (averageRating) => emit(AverageRatingLoadSuccess(averageRating)),
    );
  }
}

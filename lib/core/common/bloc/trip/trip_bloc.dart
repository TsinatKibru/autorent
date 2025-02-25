import 'dart:async';

import 'package:car_rent/core/common/domain/usecases/trip.dart';
import 'package:car_rent/core/usecase/usecase.dart';
import 'package:car_rent/core/common/entities/trip.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:meta/meta.dart';

part 'trip_event.dart';
part 'trip_state.dart';

class TripBloc extends Bloc<TripEvent, TripState> {
  final FetchTrips _fetchTrips;
  final FetchTripsByProfileId _fetchTripsByProfileId;
  final UpdateTripStatus _updateTripStatus;
  final ListenForTripChanges _listenForTripChanges;

  StreamSubscription<void>? _tripSubscription;

  TripBloc({
    required FetchTrips fetchTrips,
    required FetchTripsByProfileId fetchTripsByProfileId,
    required UpdateTripStatus updateTripStatus,
    required ListenForTripChanges listenForTripChanges,
  })  : _fetchTrips = fetchTrips,
        _fetchTripsByProfileId = fetchTripsByProfileId,
        _updateTripStatus = updateTripStatus,
        _listenForTripChanges = listenForTripChanges,
        super(TripInitial()) {
    on<FetchTripsEvent>(_onFetchTrips);
    on<FetchTripsByProfileIdEvent>(_onFetchTripsByProfileId);
    on<UpdateTripStatusEvent>(_onUpdateTripStatus);
    on<SubscribeToTripsChangesEvent>(_onSubscribeToTripChanges);
  }

  void _onFetchTrips(FetchTripsEvent event, Emitter<TripState> emit) async {
    emit(TripLoading());
    final result = await _fetchTrips(NoParams());
    result.fold(
      (failure) => emit(TripFailure(failure.message)),
      (trips) => emit(TripLoadSuccess(trips)),
    );
  }

  void _onFetchTripsByProfileId(
      FetchTripsByProfileIdEvent event, Emitter<TripState> emit) async {
    if (!event.isLiveUpdate) {
      emit(TripLoading()); // Only emit loading state if it's not a live update
    }
    final result = await _fetchTripsByProfileId(FetchTripsByProfileIdParams(
      profileId: event.profileId,
      host: event.host,
      status: event.status,
      startDate: event.startDate,
      endDate: event.endDate,
      limit: event.limit,
      offset: event.offset,
    ));
    result.fold(
      (failure) => emit(TripFailure(failure.message)),
      (trips) => emit(TripLoadSuccess(trips)),
    );
  }

  void _onUpdateTripStatus(
      UpdateTripStatusEvent event, Emitter<TripState> emit) async {
    emit(TripLoading());
    final res = await _updateTripStatus(
        UpdateTripStatusParams(status: event.status, id: event.id));
    res.fold(
      (failure) {
        emit(TripFailure(failure.message));
      },
      (updatedTrip) => emit(TripStatusUpdated(updatedTrip)),
    );
  }

  void _onSubscribeToTripChanges(
      SubscribeToTripsChangesEvent event, Emitter<TripState> emit) {
    _tripSubscription?.cancel(); // Only cancels trips, NOT other tables

    _tripSubscription =
        _listenForTripChanges(event.profileId, event.host).listen(
      (_) => add(FetchTripsByProfileIdEvent(
          profileId: event.profileId,
          host: event.host,
          status: event.status,
          startDate: event.startDate,
          endDate: event.endDate,
          limit: event.limit,
          offset: event.offset,
          isLiveUpdate: true)),
    );
  }

  @override
  Future<void> close() {
    _tripSubscription?.cancel();
    return super.close();
  }
}

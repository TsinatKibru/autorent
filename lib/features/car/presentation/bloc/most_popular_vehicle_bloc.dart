import 'package:car_rent/features/car/domain/entities/vehicle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:car_rent/features/car/domain/usecases/fetch_vehicles.dart';

part 'most_popular_vehicle_event.dart';
part 'most_popular_vehicle_state.dart';

class MostPopularVehicleBloc
    extends Bloc<MostPopularVehicleEvent, MostPopularVehicleState> {
  final FetchVehicles _fetchVehicles;

  MostPopularVehicleBloc({
    required FetchVehicles fetchVehicles,
  })  : _fetchVehicles = fetchVehicles,
        super(MostPopularVehicleInitial()) {
    on<FetchMostPopularVehiclesEvent>(_onFetchMostPopularVehicles);
  }

  Future<void> _onFetchMostPopularVehicles(FetchMostPopularVehiclesEvent event,
      Emitter<MostPopularVehicleState> emit) async {
    final currentState = state;
    List<Vehicle> vehicles = [];

    if (currentState is MostPopularVehicleLoadSuccess && event.page > 1) {
      vehicles = currentState.vehicles;
      emit(MostPopularVehicleLoadSuccess(vehicles, hasMore: true));
    } else {
      emit(MostPopularVehicleLoading());
    }

    final res = await _fetchVehicles(FetchVehiclesParams(
      page: event.page,
      limit: event.limit,
    ));

    res.fold(
      (failure) => emit(MostPopularVehicleFailure(failure.message)),
      (newVehicles) {
        final allVehicles = [...vehicles, ...newVehicles];
        emit(MostPopularVehicleLoadSuccess(allVehicles,
            hasMore: newVehicles.length == event.limit));
      },
    );
  }
}

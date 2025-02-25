import 'package:car_rent/core/usecase/usecase.dart';
import 'package:car_rent/features/car/domain/entities/vehicle.dart';
import 'package:car_rent/features/car/domain/usecases/create_vehicle.dart';
import 'package:car_rent/features/car/domain/usecases/delete_vehicle.dart';
import 'package:car_rent/features/car/domain/usecases/fetch_favorite_vehicles.dart';
import 'package:car_rent/features/car/domain/usecases/fetch_top_rated_vehicles.dart';
import 'package:car_rent/features/car/domain/usecases/fetch_vehicles.dart';
import 'package:car_rent/features/car/domain/usecases/get_vehicle_by_host_id.dart';
import 'package:car_rent/features/car/domain/usecases/search_vehicles.dart';
import 'package:car_rent/features/car/domain/usecases/update_vehicle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'vehicle_event.dart';
part 'vehicle_state.dart';

class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {
  final FetchVehicles _fetchVehicles;
  final CreateVehicle _createVehicle;
  final UpdateVehicle _updateVehicle;
  final DeleteVehicle _deleteVehicle;
  final FetchTopRatedVehicles _fetchTopRatedVehicles;
  final SearchVehicles _searchVehicles;
  final GetVehicleByHostId _getVehicleByHostId;
  final FetchFavoriteVehicles _fetchFavoriteVehicles;

  VehicleBloc({
    required FetchVehicles fetchVehicles,
    required CreateVehicle createVehicle,
    required UpdateVehicle updateVehicle,
    required DeleteVehicle deleteVehicle,
    required FetchTopRatedVehicles fetchTopRatedVehicles,
    required SearchVehicles searchVehicles,
    required GetVehicleByHostId getVehiclesByHostId,
    required FetchFavoriteVehicles fetchFavoriteVehicles,
  })  : _fetchVehicles = fetchVehicles,
        _createVehicle = createVehicle,
        _updateVehicle = updateVehicle,
        _deleteVehicle = deleteVehicle,
        _fetchTopRatedVehicles = fetchTopRatedVehicles,
        _searchVehicles = searchVehicles,
        _getVehicleByHostId = getVehiclesByHostId,
        _fetchFavoriteVehicles = fetchFavoriteVehicles,
        super(VehicleInitial()) {
    on<FetchVehiclesEvent>(_onFetchVehicles);
    on<CreateVehicleEvent>(_onCreateVehicle);
    on<UpdateVehicleEvent>(_onUpdateVehicle);
    on<DeleteVehicleEvent>(_onDeleteVehicle);
    on<FetchTopRatedVehiclesEvent>(_onFetchTopRatedVehicles);
    on<SearchVehiclesEvent>(_onSearchVehicles);
    on<FetchCurrentUserVehiclesEvent>(_onFetchCurrentUserVehicles);
    on<FetchFavoriteVehiclesEvent>(_onFetchFavoriteVehicles);
  }

  void _onFetchCurrentUserVehicles(
      FetchCurrentUserVehiclesEvent event, Emitter<VehicleState> emit) async {
    emit(CurrentUserVehiclesLoading());

    final res = await _getVehicleByHostId(HostIdParams(
        id: event.hostId)); // Assuming _fetchVehiclesByHostId is your use case
    res.fold(
      (failure) => emit(CurrentUserVehiclesFailure(failure.message)),
      (vehicles) => emit(CurrentUserVehiclesLoadSuccess(vehicles)),
    );
  }

  // void _onFetchVehicles(
  //     FetchVehiclesEvent event, Emitter<VehicleState> emit) async {
  //   emit(VehicleLoading());
  //   final res = await _fetchVehicles(NoParams());
  //   res.fold(
  //     (failure) => emit(VehicleFailure(failure.message)),
  //     (vehicles) => emit(VehicleLoadSuccess(vehicles)),
  //   );
  // }
  void _onFetchVehicles(
      FetchVehiclesEvent event, Emitter<VehicleState> emit) async {
    final currentState = state;
    List<Vehicle> vehicles = [];

    if (currentState is VehicleLoadSuccess && event.page > 1) {
      vehicles = currentState.vehicles;
      emit(VehicleLoadSuccess(vehicles,
          hasMore: true)); // Indicate loading more data
    } else {
      emit(VehicleLoading());
    }

    final res = await _fetchVehicles(FetchVehiclesParams(
      page: event.page,
      limit: event.limit,
    ));

    res.fold(
      (failure) => emit(VehicleFailure(failure.message)),
      (newVehicles) {
        final allVehicles = [...vehicles, ...newVehicles];
        emit(VehicleLoadSuccess(allVehicles,
            hasMore: newVehicles.length == event.limit));
      },
    );
  }

  void _onCreateVehicle(
      CreateVehicleEvent event, Emitter<VehicleState> emit) async {
    emit(VehicleLoading());
    final res =
        await _createVehicle(event.vehicle); // Pass the vehicle directly
    res.fold(
      (failure) => emit(VehicleFailure(failure.message)),
      (_) => add(FetchCurrentUserVehiclesEvent(
          hostId: event.vehicle.host)), // Refresh vehicle list after creation
    );
  }

  void _onUpdateVehicle(
      UpdateVehicleEvent event, Emitter<VehicleState> emit) async {
    emit(VehicleLoading());
    final res = await _updateVehicle(UpdateVehicleParams(
      id: event.id,
      vehicle: event.vehicle,
    ));
    res.fold(
      (failure) => emit(VehicleFailure(failure.message)),
      (updatedVehicle) => add(FetchCurrentUserVehiclesEvent(
          hostId: updatedVehicle.host)), // Refresh vehicle list after update
    );
  }

  void _onDeleteVehicle(
      DeleteVehicleEvent event, Emitter<VehicleState> emit) async {
    emit(VehicleLoading());
    final res =
        await _deleteVehicle(VehicleIdParams(event.id)); // Use VehicleIdParams
    res.fold(
      (failure) => emit(VehicleFailure(failure.message)),
      (_) => add(FetchVehiclesEvent(
          page: 1, limit: 10)), // Refresh vehicle list after deletion
    );
  }

  void _onFetchTopRatedVehicles(
      FetchTopRatedVehiclesEvent event, Emitter<VehicleState> emit) async {
    emit(TopRatedVehicleLoading());
    final res = await _fetchTopRatedVehicles(
        TopRatedVehiclesParams(limit: event.limit));
    res.fold(
      (failure) => emit(TopRatedVehicleFailure(failure.message)),
      (vehicles) => emit(TopRatedVehicleState(vehicles)),
    );
  }

  void _onSearchVehicles(
      SearchVehiclesEvent event, Emitter<VehicleState> emit) async {
    final currentState = state;
    List<Vehicle> searchResults = [];

    if (currentState is SearchVehicleState && event.page > 1) {
      searchResults = currentState.searchResults;
      emit(SearchVehicleLoading()); // Indicate loading more data
    } else {
      emit(SearchVehicleLoading());
    }

    final res = await _searchVehicles(SearchVehiclesParams(
      query: event.query,
      page: event.page,
      limit: event.limit,
    ));

    res.fold(
      (failure) => emit(SearchVehicleFailure(failure.message)),
      (newResults) {
        final allResults = [...searchResults, ...newResults];
        emit(SearchVehicleState(
          allResults,
          hasMore: newResults.length == event.limit,
        ));
      },
    );
  }

  void _onFetchFavoriteVehicles(
      FetchFavoriteVehiclesEvent event, Emitter<VehicleState> emit) async {
    emit(FavoriteVehiclesLoading());
    final res =
        await _fetchFavoriteVehicles(FetchFavoriteVehiclesParams(event.ids));
    res.fold(
      (failure) => emit(FavoriteVehiclesFailure(failure.message)),
      (vehicles) => emit(FavoriteVehiclesLoadSuccess(vehicles)),
    );
  }
}

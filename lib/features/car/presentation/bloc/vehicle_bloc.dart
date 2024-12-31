import 'package:car_rent/core/common/entities/uploaded_image.dart';
import 'package:car_rent/core/usecase/usecase.dart';
import 'package:car_rent/features/car/domain/entities/vehicle.dart';
import 'package:car_rent/features/car/domain/usecases/create_vehicle.dart';
import 'package:car_rent/features/car/domain/usecases/delete_vehicle.dart';
import 'package:car_rent/features/car/domain/usecases/fetch_vehicles.dart';
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

  VehicleBloc({
    required FetchVehicles fetchVehicles,
    required CreateVehicle createVehicle,
    required UpdateVehicle updateVehicle,
    required DeleteVehicle deleteVehicle,
  })  : _fetchVehicles = fetchVehicles,
        _createVehicle = createVehicle,
        _updateVehicle = updateVehicle,
        _deleteVehicle = deleteVehicle,
        super(VehicleInitial()) {
    on<FetchVehiclesEvent>(_onFetchVehicles);
    on<CreateVehicleEvent>(_onCreateVehicle);
    on<UpdateVehicleEvent>(_onUpdateVehicle);
    on<DeleteVehicleEvent>(_onDeleteVehicle);
  }

  void _onFetchVehicles(
      FetchVehiclesEvent event, Emitter<VehicleState> emit) async {
    emit(VehicleLoading());
    final res = await _fetchVehicles(NoParams());
    res.fold(
      (failure) => emit(VehicleFailure(failure.message)),
      (vehicles) => emit(VehicleLoadSuccess(vehicles)),
    );
  }

  void _onCreateVehicle(
      CreateVehicleEvent event, Emitter<VehicleState> emit) async {
    emit(VehicleLoading());
    final res =
        await _createVehicle(event.vehicle); // Pass the vehicle directly
    res.fold(
      (failure) => emit(VehicleFailure(failure.message)),
      (_) => add(FetchVehiclesEvent()), // Refresh vehicle list after creation
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
      (_) => add(FetchVehiclesEvent()), // Refresh vehicle list after update
    );
  }

  void _onDeleteVehicle(
      DeleteVehicleEvent event, Emitter<VehicleState> emit) async {
    emit(VehicleLoading());
    final res =
        await _deleteVehicle(VehicleIdParams(event.id)); // Use VehicleIdParams
    res.fold(
      (failure) => emit(VehicleFailure(failure.message)),
      (_) => add(FetchVehiclesEvent()), // Refresh vehicle list after deletion
    );
  }
}

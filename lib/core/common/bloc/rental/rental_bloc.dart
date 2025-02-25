import 'package:car_rent/core/common/domain/usecases/rental.dart';

import 'package:car_rent/core/common/entities/rental.dart';
import 'package:car_rent/core/usecase/usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:meta/meta.dart';

part 'rental_event.dart';
part 'rental_state.dart';

class RentalBloc extends Bloc<RentalEvent, RentalState> {
  final GetRentals getRentals;
  final CreateRental createRental;
  final UpdateRentalStatus updateRentalStatus;

  RentalBloc({
    required this.getRentals,
    required this.createRental,
    required this.updateRentalStatus,
  }) : super(RentalInitial()) {
    on<FetchRentalsEvent>(_onFetchRentals);
    on<CreateRentalEvent>(_onCreateRental);
    on<UpdateRentalStatusEvent>(_onUpdateRentalStatus);
  }

  void _onFetchRentals(
      FetchRentalsEvent event, Emitter<RentalState> emit) async {
    emit(RentalLoading());
    final res = await getRentals(NoParams());
    res.fold(
      (failure) => emit(RentalFailure(failure.message)),
      (rentals) => emit(RentalLoadSuccess(rentals)),
    );
  }

  void _onCreateRental(
      CreateRentalEvent event, Emitter<RentalState> emit) async {
    emit(RentalLoading());
    final res = await createRental(event.rental);
    res.fold(
      (failure) => emit(RentalFailure(failure.message)),
      (_) => add(FetchRentalsEvent()), // Refresh rentals
    );
  }

  void _onUpdateRentalStatus(
      UpdateRentalStatusEvent event, Emitter<RentalState> emit) async {
    emit(RentalLoading());
    final res = await updateRentalStatus(UpdateRentalStatusParams(
        rentalId: event.rentalId, status: event.status));
    res.fold(
      (failure) => emit(RentalFailure(failure.message)),
      (_) => add(FetchRentalsEvent()), // Refresh rentals
    );
  }
}

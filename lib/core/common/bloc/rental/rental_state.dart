part of 'rental_bloc.dart';

@immutable
abstract class RentalState {}

class RentalInitial extends RentalState {}

class RentalLoading extends RentalState {}

class RentalLoadSuccess extends RentalState {
  final List<Rental> rentals;
  RentalLoadSuccess(this.rentals);
}

class RentalFailure extends RentalState {
  final String message;
  RentalFailure(this.message);
}

class RentalStatusUpdated extends RentalState {}

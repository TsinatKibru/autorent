part of 'rental_bloc.dart';

@immutable
abstract class RentalEvent {}

class FetchRentalsEvent extends RentalEvent {}

class CreateRentalEvent extends RentalEvent {
  final Rental rental;
  CreateRentalEvent(this.rental);
}

class UpdateRentalStatusEvent extends RentalEvent {
  final int rentalId;
  final String status;
  UpdateRentalStatusEvent(this.rentalId, this.status);
}

import 'package:car_rent/core/common/domain/repository/rental_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:car_rent/core/error/failure.dart';
import 'package:car_rent/core/usecase/usecase.dart';

import 'package:car_rent/core/common/entities/rental.dart';

class CreateRental implements Usecase<Unit, Rental> {
  final RentalRepository repository;

  CreateRental(this.repository);

  @override
  Future<Either<Failure, Unit>> call(Rental rental) async {
    return await repository.createRental(rental);
  }
}

class UpdateRentalStatus implements Usecase<Unit, UpdateRentalStatusParams> {
  final RentalRepository repository;

  UpdateRentalStatus(this.repository);

  @override
  Future<Either<Failure, Unit>> call(UpdateRentalStatusParams params) async {
    return await repository.updateRentalStatus(params.rentalId, params.status);
  }
}

class GetRentals implements Usecase<List<Rental>, NoParams> {
  final RentalRepository repository;

  GetRentals(this.repository);

  @override
  Future<Either<Failure, List<Rental>>> call(NoParams params) async {
    return await repository.getRentals();
  }
}

class UpdateRentalStatusParams {
  final int rentalId;
  final String status;

  UpdateRentalStatusParams({
    required this.rentalId,
    required this.status,
  });
}

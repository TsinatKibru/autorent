import 'package:car_rent/core/error/failure.dart';
import 'package:car_rent/core/usecase/usecase.dart';
import 'package:car_rent/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class Logout implements Usecase<void, NoParams> {
  final AuthRepository authRepository;

  Logout(this.authRepository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await authRepository.logout();
  }
}

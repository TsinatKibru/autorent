import 'package:car_rent/core/error/failure.dart';
import 'package:car_rent/core/usecase/usecase.dart';
import 'package:car_rent/core/common/entities/user.dart';
import 'package:car_rent/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUser implements Usecase<User, NoParams> {
  final AuthRepository authRepository;

  CurrentUser(this.authRepository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await authRepository.currentUser();
  }
}

import 'package:car_rent/core/error/failure.dart';
import 'package:car_rent/core/usecase/usecase.dart';
import 'package:car_rent/core/common/entities/user.dart';
import 'package:car_rent/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignin implements Usecase<User, UserSignInParams> {
  final AuthRepository authRepository;

  UserSignin(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserSignInParams params) async {
    return await authRepository.loginWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignInParams {
  final String email;
  final String password;

  UserSignInParams({
    required this.email,
    required this.password,
  });
}

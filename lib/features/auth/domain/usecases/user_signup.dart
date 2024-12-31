// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:car_rent/core/error/failure.dart';
import 'package:car_rent/core/usecase/usecase.dart';
import 'package:car_rent/core/common/entities/user.dart';
import 'package:car_rent/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignup implements Usecase<User, UserSignUpParams> {
  final AuthRepository authRepository;

  UserSignup(this.authRepository);
  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async {
    print("user Sign up usecase");
    return await authRepository.signUpWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpParams {
  final String email;
  final String password;
  final String name;
  UserSignUpParams({
    required this.email,
    required this.password,
    required this.name,
  });
}

import 'package:car_rent/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:car_rent/core/usecase/usecase.dart';
import 'package:car_rent/core/common/entities/user.dart';
import 'package:car_rent/features/auth/domain/usecases/current_user.dart';
import 'package:car_rent/features/auth/domain/usecases/log_out.dart';
import 'package:car_rent/features/auth/domain/usecases/user_signin.dart';
import 'package:car_rent/features/auth/domain/usecases/user_signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignup _userSignup;
  final UserSignin _userSignin;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;
  final Logout _logout;

  AuthBloc({
    required UserSignup userSignUp,
    required UserSignin userSignIn,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
    required Logout logout,
  })  : _userSignup = userSignUp,
        _userSignin = userSignIn,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        _logout = logout,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthSignIn>(_onAuthSignIn);
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
    on<AuthLogout>(_onAuthLogout);
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    final res = await _userSignup(
      UserSignUpParams(
        email: event.email,
        password: event.password,
        name: event.name,
      ),
    );

    res.fold(
      (failure) {
        emit(AuthFailure(failure.message)); // Emit failure state
      },
      (user) {
        _emitAuthSuccess(user, emit); // Emit success state
      },
    );
  }

  void _onAuthSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    final res = await _userSignin(
      UserSignInParams(
        email: event.email,
        password: event.password,
      ),
    );

    res.fold(
      (failure) {
        emit(AuthFailure(failure.message)); // Emit failure state
      },
      (user) {
        _emitAuthSuccess(user, emit); // Emit success state
      },
    );
  }

  void _isUserLoggedIn(
      AuthIsUserLoggedIn event, Emitter<AuthState> emit) async {
    final res = await _currentUser(NoParams());

    res.fold(
      (failure) {
        emit(AuthFailure(failure.message)); // Emit failure state
      },
      (user) {
        _emitAuthSuccess(user, emit); // Emit success state
      },
    );
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    print("users: ${user}");
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }

  void _onAuthLogout(AuthLogout event, Emitter<AuthState> emit) async {
    final res = await _logout(NoParams());

    res.fold(
      (failure) {
        emit(AuthFailure(failure.message));
      },
      (_) {
        _appUserCubit.updateUser(null); // Clear the user state
        emit(AuthInitial()); // Reset to initial state
      },
    );
  }
}

import 'package:car_rent/core/common/bloc/image_bloc.dart';
import 'package:car_rent/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:car_rent/core/common/data/datasources/image_remote_data_source.dart';
import 'package:car_rent/core/common/data/repository/image_repository_impl.dart';
import 'package:car_rent/core/common/domain/repository/image_repository.dart';
import 'package:car_rent/core/common/domain/usecases/get_signed_url.dart';
import 'package:car_rent/core/common/domain/usecases/upload_image.dart';
import 'package:car_rent/core/secrets/app_secrets.dart';
import 'package:car_rent/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:car_rent/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:car_rent/features/auth/domain/repository/auth_repository.dart';
import 'package:car_rent/features/auth/domain/usecases/current_user.dart';
import 'package:car_rent/features/auth/domain/usecases/log_out.dart';
import 'package:car_rent/features/auth/domain/usecases/user_signin.dart';
import 'package:car_rent/features/auth/domain/usecases/user_signup.dart';
import 'package:car_rent/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:car_rent/features/car/data/datasources/vehicles_remote_data_source.dart';
import 'package:car_rent/features/car/data/repositories/vehicles_repository_impl.dart';
import 'package:car_rent/features/car/domain/repository/vehicle_repository.dart';
import 'package:car_rent/features/car/domain/usecases/create_vehicle.dart';
import 'package:car_rent/features/car/domain/usecases/delete_vehicle.dart';
import 'package:car_rent/features/car/domain/usecases/fetch_vehicles.dart';
import 'package:car_rent/features/car/domain/usecases/update_vehicle.dart';
import 'package:car_rent/features/car/presentation/bloc/vehicle_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initVehicle();
  _initImageUpload();
  final supabase = await Supabase.initialize(
      url: AppSecrets.supabaseUrl, anonKey: AppSecrets.anonkey);
  serviceLocator.registerLazySingleton(() => supabase.client);
  //core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(serviceLocator()));
  print("AuthRemoteDataSource registered");
  serviceLocator.registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator()));
  serviceLocator.registerFactory(() => UserSignup(serviceLocator()));
  serviceLocator.registerFactory(() => UserSignin(serviceLocator()));
  serviceLocator.registerFactory(() => CurrentUser(serviceLocator()));
  serviceLocator.registerFactory(() => Logout(serviceLocator()));
  serviceLocator.registerLazySingleton(() => AuthBloc(
      userSignUp: serviceLocator(),
      userSignIn: serviceLocator(),
      currentUser: serviceLocator(),
      appUserCubit: serviceLocator(),
      logout: serviceLocator()));
}

void _initVehicle() {
  // Register Vehicle-related dependencies
  serviceLocator.registerFactory<VehiclesRemoteDataSource>(() =>
      VehiclesRemoteDataSourceImpl(serviceLocator())); // Vehicle data source
  print("VehiclesRemoteDataSource registered");
  serviceLocator.registerFactory<VehiclesRepository>(
      () => VehiclesRepositoryImpl(serviceLocator())); // Vehicle repository
  print("VehiclesRepository registered");
  serviceLocator.registerFactory(
      () => CreateVehicle(serviceLocator())); // Use case for creating vehicle
  print("CreateVehicle registered");
  serviceLocator.registerFactory(
      () => UpdateVehicle(serviceLocator())); // Use case for updating vehicle
  serviceLocator.registerFactory(
      () => DeleteVehicle(serviceLocator())); // Use case for deleting vehicle
  serviceLocator.registerFactory(
      () => FetchVehicles(serviceLocator())); // Use case for fetching vehicles

  // Register VehicleBloc
  serviceLocator.registerLazySingleton(() => VehicleBloc(
        fetchVehicles: serviceLocator(),
        createVehicle: serviceLocator(),
        updateVehicle: serviceLocator(),
        deleteVehicle: serviceLocator(),
      ));
}

void _initImageUpload() {
  // Register Vehicle-related dependencies
  serviceLocator.registerFactory<ImageRemoteDataSource>(
      () => ImageRemoteDataSourceImpl(serviceLocator())); // Vehicle data source
  print("ImageRemoteDataSource registered");
  serviceLocator.registerFactory<ImageRepository>(
      () => ImageRepositoryImpl(serviceLocator())); // Vehicle repository
  print("ImageRepository registered");
  serviceLocator.registerFactory(
      () => UploadImage(serviceLocator())); // Use case for creating vehicle
  print("CreateVehicle registered");
  serviceLocator.registerFactory(() => GetSignedUrl(serviceLocator()));

  // Register VehicleBloc
  serviceLocator.registerLazySingleton(() => ImageBloc(
        uploadImage: serviceLocator(),
        getSignedUrl: serviceLocator(),
      ));
}

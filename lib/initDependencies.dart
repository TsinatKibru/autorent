import 'package:car_rent/core/common/bloc/image/image_bloc.dart';
import 'package:car_rent/core/common/bloc/profile/profile_bloc.dart';
import 'package:car_rent/core/common/bloc/profile/vehicle_owner/bloc/vehicle_owner_profile_bloc.dart';
import 'package:car_rent/core/common/bloc/rating/average_rating_bloc.dart';
import 'package:car_rent/core/common/bloc/rating/rating_bloc.dart';
import 'package:car_rent/core/common/bloc/rental/rental_bloc.dart';
import 'package:car_rent/core/common/bloc/transation/transaction_bloc.dart';
import 'package:car_rent/core/common/bloc/trip/trip_bloc.dart';
import 'package:car_rent/core/common/bloc/wallet/wallet_bloc.dart';
import 'package:car_rent/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:car_rent/core/common/data/datasources/image_remote_data_source.dart';
import 'package:car_rent/core/common/data/datasources/profile_datasource.dart';
import 'package:car_rent/core/common/data/datasources/rating_remote_data_source.dart';
import 'package:car_rent/core/common/data/datasources/rental_remote_data_source.dart';
import 'package:car_rent/core/common/data/datasources/transaction_remote_data_source.dart';
import 'package:car_rent/core/common/data/datasources/trips_remote_data_source.dart';
import 'package:car_rent/core/common/data/datasources/wallets_remote_data_source.dart';
import 'package:car_rent/core/common/data/repository/image_repository_impl.dart';
import 'package:car_rent/core/common/data/repository/profile_repository_impl.dart';
import 'package:car_rent/core/common/data/repository/rating_repository_impl.dart';
import 'package:car_rent/core/common/data/repository/rental_repository_impl.dart';
import 'package:car_rent/core/common/data/repository/transactions_repository_impl.dart';
import 'package:car_rent/core/common/data/repository/trip_repository_impl.dart';
import 'package:car_rent/core/common/data/repository/wallets_repository_impl.dart';
import 'package:car_rent/core/common/domain/repository/image_repository.dart';
import 'package:car_rent/core/common/domain/repository/profile_repository.dart';
import 'package:car_rent/core/common/domain/repository/rating_repository.dart';
import 'package:car_rent/core/common/domain/repository/rental_repository.dart';
import 'package:car_rent/core/common/domain/repository/transaction_repositories.dart';
import 'package:car_rent/core/common/domain/repository/trip_repository.dart';
import 'package:car_rent/core/common/domain/repository/wallets_repository.dart';
import 'package:car_rent/core/common/domain/usecases/add_favorites.dart';
import 'package:car_rent/core/common/domain/usecases/fetch_vehicle_owner_profile.dart';
import 'package:car_rent/core/common/domain/usecases/get_profile.dart';
import 'package:car_rent/core/common/domain/usecases/get_signed_url.dart';
import 'package:car_rent/core/common/domain/usecases/ratings_usecase.dart';
import 'package:car_rent/core/common/domain/usecases/rental.dart';
import 'package:car_rent/core/common/domain/usecases/transaction_usecases.dart';
import 'package:car_rent/core/common/domain/usecases/trip.dart';
import 'package:car_rent/core/common/domain/usecases/upload_image.dart';
import 'package:car_rent/core/common/domain/usecases/wallets_usecases.dart';
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
import 'package:car_rent/features/car/domain/usecases/fetch_favorite_vehicles.dart';
import 'package:car_rent/features/car/domain/usecases/fetch_top_rated_vehicles.dart';
import 'package:car_rent/features/car/domain/usecases/fetch_vehicles.dart';
import 'package:car_rent/features/car/domain/usecases/get_vehicle_by_host_id.dart';
import 'package:car_rent/features/car/domain/usecases/search_vehicles.dart';
import 'package:car_rent/features/car/domain/usecases/update_vehicle.dart';
import 'package:car_rent/features/car/presentation/bloc/most_popular_vehicle_bloc.dart';
import 'package:car_rent/features/car/presentation/bloc/vehicle_bloc.dart';
import 'package:car_rent/features/messaging/data/datasources/messages_remote_data_source.dart';
import 'package:car_rent/features/messaging/data/repository/messages_repository_impl.dart';
import 'package:car_rent/features/messaging/domain/repository/messages_repository.dart';
import 'package:car_rent/features/messaging/domain/usecases/message_usecases.dart';
import 'package:car_rent/features/messaging/presentation/bloc/message_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initVehicle();
  _initImageUpload();
  _initProfile();
  _initRental();
  _initTrip();
  _initWallet();
  _initRating();
  _initMessage();
  _initTransaction();
  final supabase = await Supabase.initialize(
      url: AppSecrets.supabaseUrl, anonKey: AppSecrets.anonkey);
  serviceLocator.registerLazySingleton(() => supabase.client);
  //core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(serviceLocator()));
  // // print("AuthRemoteDataSource registered");
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
  // print("VehiclesRemoteDataSource registered");
  serviceLocator.registerFactory<VehiclesRepository>(
      () => VehiclesRepositoryImpl(serviceLocator())); // Vehicle repository
  // print("VehiclesRepository registered");
  serviceLocator.registerFactory(
      () => CreateVehicle(serviceLocator())); // Use case for creating vehicle
  // print("CreateVehicle registered");
  serviceLocator.registerFactory(
      () => UpdateVehicle(serviceLocator())); // Use case for updating vehicle
  serviceLocator.registerFactory(
      () => DeleteVehicle(serviceLocator())); // Use case for deleting vehicle
  serviceLocator.registerFactory(
      () => FetchVehicles(serviceLocator())); // Use case for fetching vehicles
  serviceLocator.registerFactory(() => FetchTopRatedVehicles(serviceLocator()));
  serviceLocator.registerFactory(() => SearchVehicles(serviceLocator()));
  serviceLocator.registerFactory(() => GetVehicleByHostId(serviceLocator()));
  serviceLocator.registerFactory(() => FetchFavoriteVehicles(serviceLocator()));

  // Register VehicleBloc
  serviceLocator.registerLazySingleton(() => VehicleBloc(
        fetchVehicles: serviceLocator(),
        createVehicle: serviceLocator(),
        updateVehicle: serviceLocator(),
        deleteVehicle: serviceLocator(),
        fetchTopRatedVehicles: serviceLocator(),
        searchVehicles: serviceLocator(),
        getVehiclesByHostId: serviceLocator(),
        fetchFavoriteVehicles: serviceLocator(),
      ));

  serviceLocator.registerLazySingleton(
      () => MostPopularVehicleBloc(fetchVehicles: serviceLocator()));
}

void _initImageUpload() {
  // Register Vehicle-related dependencies
  serviceLocator.registerFactory<ImageRemoteDataSource>(
      () => ImageRemoteDataSourceImpl(serviceLocator())); // Vehicle data source
  // print("ImageRemoteDataSource registered");
  serviceLocator.registerFactory<ImageRepository>(
      () => ImageRepositoryImpl(serviceLocator())); // Vehicle repository
  // print("ImageRepository registered");
  serviceLocator.registerFactory(
      () => UploadImage(serviceLocator())); // Use case for creating vehicle
  // print("CreateVehicle registered");
  serviceLocator.registerFactory(() => GetSignedUrl(serviceLocator()));

  // Register VehicleBloc
  serviceLocator.registerLazySingleton(() => ImageBloc(
        uploadImage: serviceLocator(),
        getSignedUrl: serviceLocator(),
      ));
}

void _initProfile() {
  // Register Vehicle-related dependencies
  serviceLocator.registerFactory<ProfileRemoteDataSource>(() =>
      ProfileRemoteDataSourceImpl(serviceLocator())); // Vehicle data source
  // print("ProfileRemoteDataSource registered");
  serviceLocator.registerFactory<ProfileRepository>(
      () => ProfileRepositoryImpl(serviceLocator())); // Vehicle repository
  // print("ProfileRepository registered");
  serviceLocator.registerFactory(
      () => GetProfile(serviceLocator())); // Use case for creating vehicle
  // print("GetProfile registered");
  serviceLocator.registerFactory(() => AddFavorite(serviceLocator()));
  serviceLocator.registerFactory(() => UpdateProfile(serviceLocator()));
  serviceLocator
      .registerFactory(() => FetchVehicleOwnerProfile(serviceLocator()));

  // Register VehicleBloc
  serviceLocator.registerLazySingleton(() => ProfileBloc(
        getProfile: serviceLocator(),
        updateProfile: serviceLocator(),
        addFavorite: serviceLocator(),
      ));

  serviceLocator.registerLazySingleton(() => VehicleOwnerProfileBloc(
        fetchVehicleOwnerProfile: serviceLocator(),
      ));
}

void _initRental() {
  // Register Vehicle-related dependencies
  serviceLocator.registerFactory<RentalRemoteDataSource>(() =>
      RentalRemoteDataSourceImpl(serviceLocator())); // Vehicle data source
  // print("RentalRemoteDataSource registered");
  serviceLocator.registerFactory<RentalRepository>(
      () => RentalRepositoryImpl(serviceLocator())); // Vehicle repository
  // print("RentalRepository registered");
  serviceLocator.registerFactory(
      () => CreateRental(serviceLocator())); // Use case for creating vehicle
  // print("CreateRental registered");
  serviceLocator.registerFactory(() => UpdateRentalStatus(serviceLocator()));
  serviceLocator.registerFactory(() => GetRentals(serviceLocator()));

  serviceLocator.registerLazySingleton(() => RentalBloc(
        getRentals: serviceLocator(),
        createRental: serviceLocator(),
        updateRentalStatus: serviceLocator(),
      ));
}

void _initTrip() {
  // Register Vehicle-related dependencies
  serviceLocator.registerFactory<TripsRemoteDataSource>(
      () => TripsRemoteDataSourceImpl(serviceLocator())); // Vehicle data source
  // print("RentalRemoteDataSource registered");
  serviceLocator.registerFactory<TripsRepository>(
      () => TripsRepositoryImpl(serviceLocator())); // Vehicle repository
  // print("TripRepository registered");
  serviceLocator.registerFactory(
      () => FetchTrips(serviceLocator())); // Use case for creating vehicle
  // print("CreateTrip registered");
  serviceLocator.registerFactory(() => FetchTripsByProfileId(serviceLocator()));
  serviceLocator.registerFactory(() => UpdateTripStatus(serviceLocator()));
  serviceLocator.registerFactory(() => ListenForTripChanges(serviceLocator()));

  serviceLocator.registerLazySingleton(() => TripBloc(
      fetchTrips: serviceLocator(),
      fetchTripsByProfileId: serviceLocator(),
      updateTripStatus: serviceLocator(),
      listenForTripChanges: serviceLocator()));
}

void _initWallet() {
  // Register Wallet-related dependencies
  serviceLocator.registerFactory<WalletsRemoteDataSource>(() =>
      WalletsRemoteDataSourceImpl(serviceLocator())); // Wallet data source
  // print("WalletsRemoteDataSource registered");

  serviceLocator.registerFactory<WalletsRepository>(
      () => WalletsRepositoryImpl(serviceLocator())); // Wallet repository
  // print("WalletsRepository registered");

  serviceLocator.registerFactory(() => GetWalletByProfileId(
      serviceLocator())); // Use case for fetching wallet by profile ID
  // print("GetWalletByProfileId registered");

  serviceLocator.registerFactory(() => UpdateWalletBalance(
      serviceLocator())); // Use case for updating wallet balance
  // print("UpdateWalletBalance registered");

  serviceLocator.registerFactory(() =>
      AddTransaction(serviceLocator())); // Use case for adding a transaction
  // print("AddTransaction registered");

  serviceLocator.registerFactory(() => CreateWallet(serviceLocator()));

  // Register WalletBloc
  serviceLocator.registerLazySingleton(() => WalletBloc(
      getWalletByProfileId: serviceLocator(),
      updateWalletBalance: serviceLocator(),
      addTransaction: serviceLocator(),
      createWallet: serviceLocator()));
}

void _initRating() {
  // Register Wallet-related dependencies
  serviceLocator.registerFactory<RatingRemoteDataSource>(
      () => RatingRemoteDataSourceImpl(serviceLocator())); // Wallet data source
  // print("RatingRemoteDataSource registered");

  serviceLocator.registerFactory<RatingRepository>(
      () => RatingRepositoryImpl(serviceLocator())); // Wallet repository
  // print("RatingRepository registered");

  serviceLocator.registerFactory(() => CreateRating(
      serviceLocator())); // Use case for fetching wallet by profile ID
  // print("GetWalletByProfileId registered");

  serviceLocator.registerFactory(() =>
      GetRatings(serviceLocator())); // Use case for updating wallet balance
  // print("UpdateRatingBalance registered");

  serviceLocator.registerFactory(() => GetRatingsByVehicleId(
      serviceLocator())); // Use case for updating wallet balance
  // print("GetRatingsByVehicleId registered");

  serviceLocator.registerFactory(() => GetRatingsByProfileId(
      serviceLocator())); // Use case for updating wallet balance
  // print("GetRatingsByProfileId registered");

  serviceLocator.registerFactory(() => GetAverageRatingByVehicleId(
      serviceLocator())); // Use case for updating wallet balance
  // print("GetAverageRatingByVehicleId registered");

  // Register WalletBloc
  serviceLocator.registerLazySingleton(() => RatingBloc(
      createRating: serviceLocator(),
      getRatings: serviceLocator(),
      getRatingsByVehicleId: serviceLocator(),
      getRatingsByProfileId: serviceLocator(),
      getAverageRatingByVehicleId: serviceLocator()));

  serviceLocator.registerLazySingleton(
      () => AverageRatingBloc(getAverageRatingByVehicleId: serviceLocator()));
}

void _initMessage() {
  // Ensure the remote data source is registered first
  serviceLocator.registerFactory<MessagesRemoteDataSource>(
      () => MessagesRemoteDataSourceImpl(serviceLocator()));

  // print("MessagesRemoteDataSource registered");

  // Register Message repository
  serviceLocator.registerFactory<MessagesRepository>(
      () => MessagesRepositoryImpl(serviceLocator()));

  // print("MessagesRepository registered");

  // Register Use Cases
  serviceLocator.registerFactory(() => FetchMessages(serviceLocator()));
  serviceLocator.registerFactory(() => CreateMessage(serviceLocator()));
  serviceLocator.registerFactory(() => UpdateMessage(serviceLocator()));
  serviceLocator.registerFactory(() => DeleteMessage(serviceLocator()));

  // Register MessageBloc
  serviceLocator.registerLazySingleton(() => MessageBloc(
      fetchMessages: serviceLocator(),
      createMessage: serviceLocator(),
      updateMessage: serviceLocator(),
      deleteMessage: serviceLocator(),
      messagesRepository: serviceLocator()));

  // print("MessageBloc registered");
}

void _initTransaction() {
  serviceLocator.registerFactory<TransactionRemoteDataSource>(
      () => TransactionRemoteDataSourceImpl(serviceLocator()));
  serviceLocator.registerFactory<TransactionRepository>(
      () => TransactionRepositoryImpl(serviceLocator()));
  serviceLocator.registerFactory(() => FetchTransactions(serviceLocator()));
  serviceLocator.registerFactory(() => CreateTransaction(serviceLocator()));
  serviceLocator.registerFactory(() => UpdateTransaction(serviceLocator()));
  serviceLocator.registerFactory(() => DeleteTransaction(serviceLocator()));
  serviceLocator.registerFactory(
      () => GetTransactionsByWalletId(serviceLocator())); // New use case

  serviceLocator.registerLazySingleton(() => TransactionBloc(
      fetchTransactions: serviceLocator(),
      createTransaction: serviceLocator(),
      updateTransaction: serviceLocator(),
      deleteTransaction: serviceLocator(),
      getTransactionsByWalletId: serviceLocator()));
}

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
import 'package:car_rent/core/theme/theme.dart';
import 'package:car_rent/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:car_rent/features/car/presentation/bloc/most_popular_vehicle_bloc.dart';
import 'package:car_rent/features/car/presentation/bloc/vehicle_bloc.dart';
import 'package:car_rent/features/messaging/presentation/bloc/message_bloc.dart';
import 'package:car_rent/features/navigation/presentation/pages/splash_page.dart';
import 'package:car_rent/initDependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // final supabase = await Supabase.initialize(
  //     url: AppSecrets.supabaseUrl, anonKey: AppSecrets.anonkey);

  // runApp(MultiBlocProvider(
  //   providers: [
  //     BlocProvider(
  //       create: (_) => AuthBloc(
  //           userSignUp: UserSignup(
  //               AuthRepositoryImpl(AuthRemoteDataSourceImpl(supabase.client)))),
  //     ), // this is why we need dependency injection : to instantiate one provider we had to pass all these
  //   ],
  //   child: const MyApp(),
  // ));
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),
      BlocProvider(
          create: (_) => serviceLocator<
              AuthBloc>()), // this is why we need dependency injection : to instantiate one provider we had to pass all these
      BlocProvider(create: (_) => serviceLocator<VehicleBloc>()),
      BlocProvider(create: (_) => serviceLocator<ImageBloc>()),
      BlocProvider(create: (_) => serviceLocator<ProfileBloc>()),
      BlocProvider(create: (_) => serviceLocator<VehicleOwnerProfileBloc>()),
      BlocProvider(create: (_) => serviceLocator<RentalBloc>()),
      BlocProvider(create: (_) => serviceLocator<TripBloc>()),
      BlocProvider(create: (_) => serviceLocator<WalletBloc>()),
      BlocProvider(create: (_) => serviceLocator<RatingBloc>()),
      BlocProvider(create: (_) => serviceLocator<MessageBloc>()),
      BlocProvider(create: (_) => serviceLocator<MostPopularVehicleBloc>()),
      BlocProvider(create: (_) => serviceLocator<AverageRatingBloc>()),
      BlocProvider(create: (_) => serviceLocator<TransactionBloc>()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Go Rent',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        themeMode: ThemeMode.light,
        darkTheme: AppTheme.darkTheme,
        home: const SplashPage());
  }
}

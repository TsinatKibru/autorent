import 'package:car_rent/core/common/bloc/profile/profile_bloc.dart';
import 'package:car_rent/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:car_rent/core/common/entities/user.dart';
import 'package:car_rent/features/auth/presentation/pages/local_auth_page.dart';
import 'package:car_rent/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:car_rent/features/auth/presentation/pages/login_page.dart';
import 'package:car_rent/features/navigation/presentation/widgets/bottom_navigation_bar_widget.dart';
import 'package:car_rent/features/auth/presentation/bloc/auth_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();

    // Trigger the login check when the splash page is loaded
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());

    // Trigger fetching vehicles

    // Simulate a delay for the splash screen
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted && !_isInitialized) {
        _navigateToLogin();
      }
    });
  }

  void _navigateToLogin() {
    setState(() {
      _isInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent.withOpacity(0.9),
      body: BlocSelector<AppUserCubit, AppUserState, User?>(
        selector: (state) {
          print("AppUserLoggedIn: ${state}");
          if (state is AppUserLoggedIn) {
            return state.user;
          }
          return null;
        },
        builder: (context, user) {
          if (user != null) {
            // Trigger fetching the profile when the user is logged in
            context.read<ProfileBloc>().add(FetchProfileEvent(id: user.id));
            print("objekdvkjdct");
            // context.read<WalletBloc>().add(FetchWalletEvent(
            //       user.id,
            //     ));

            return LocalAuthPage();
          }
          if (_isInitialized && user == null) {
            print("djfvkdsfsdfj");
            return const LogInPage();
          }
          return _buildSplashBody();
        },
      ),
    );
  }

  Widget _buildSplashBody() {
    return Stack(
      children: [
        // Background images
        Positioned(
          top: 30,
          left: 10,
          child: Image.asset(
            'assets/images/Clip_path_group2.png',
            width: 250,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 20,
          left: 10,
          child: Image.asset(
            'assets/images/Clip_path_group.png',
            width: 350,
            fit: BoxFit.fitWidth,
          ),
        ),
        // Transparent greenish cover
        Positioned.fill(
          child: Container(
            color: const Color.fromARGB(255, 158, 241, 161)
                .withOpacity(0.2), // Semi-transparent green overlay
          ),
        ),
        // Center content
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Centralized Text
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                  softWrap: true,
                  'Let\'s pick up',
                  textAlign: TextAlign.center, // Center align text
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34, // Slightly smaller font for better scaling
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                  'A CAR',
                  style: TextStyle(
                    fontFamily: 'Digital7', // Apply the Digital-7 font
                    color: Colors.greenAccent,
                    fontSize: 50,
                    height: 0.8,
                  ),
                ),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                  softWrap: true,
                  'for you',
                  textAlign: TextAlign.center, // Center align text
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34, // Slightly smaller font for better scaling
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
              ),
              // Spacing below the text
              // Splash image
              Image.asset(
                'assets/images/splashbg.png',
                width: double.infinity,
                height: 450, // Adjusted height for proportional scaling
                fit: BoxFit.fitWidth,
              ),
              const SizedBox(height: 20),
              // Get Started Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: AuthGradientButton(
                  buttonText: 'Get Started',
                  onPressed: () {
                    // Add button action here
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

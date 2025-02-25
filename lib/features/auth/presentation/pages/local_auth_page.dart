import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:car_rent/features/navigation/presentation/widgets/bottom_navigation_bar_widget.dart';

class LocalAuthPage extends StatefulWidget {
  const LocalAuthPage({Key? key}) : super(key: key);

  @override
  State<LocalAuthPage> createState() => _LocalAuthPageState();
}

class _LocalAuthPageState extends State<LocalAuthPage> {
  final LocalAuthentication _localAuth = LocalAuthentication();
  bool _isAuthenticating = false;

  @override
  void initState() {
    super.initState();
    _authenticate();
  }

  Future<void> _authenticate() async {
    bool canCheckBiometrics = await _localAuth.canCheckBiometrics;
    bool isDeviceSupported = await _localAuth.isDeviceSupported();

    if (canCheckBiometrics && isDeviceSupported) {
      try {
        setState(() {
          _isAuthenticating = true;
        });

        bool authenticated = await _localAuth.authenticate(
          localizedReason: "Authenticate to continue",
          options: const AuthenticationOptions(
            biometricOnly: false,
            stickyAuth: true,
          ),
        );

        if (authenticated) {
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => BottomNavigationBarWidget(),
              ),
            );
          }
        } else {
          _authenticate(); // Retry authentication automatically
        }
      } catch (e) {
        _authenticate(); // Retry authentication if there's an error
      }
    } else {
      if (mounted) {
        Navigator.pop(
            context); // Close the screen if biometrics are unavailable
      }
    }
  }

  Future<bool> _onWillPop() async {
    return false; // Disable back button
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Darker background
      body: BottomNavigationBarWidget(),
    );
  }
}

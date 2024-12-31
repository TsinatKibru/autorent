import 'package:car_rent/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FancyLoader extends StatelessWidget {
  const FancyLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SpinKitWave(
        color: AppPalette.primaryColor, // Set the color to your theme color
        size: 50.0, // Adjust the size as needed
      ),
    );
  }
}

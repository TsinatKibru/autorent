import 'package:car_rent/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class VehicleGradientButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;

  const VehicleGradientButton({
    Key? key,
    required this.onPressed,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppPalette.primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Text(
        buttonText,
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
      ),
    );
  }
}

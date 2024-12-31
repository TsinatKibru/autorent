// import 'package:flutter/material.dart';
// import 'package:car_rent/core/theme/app_pallete.dart';

// class CarRentGradientButton extends StatelessWidget {
//   final String buttonText;
//   final VoidCallback onPressed;
//   final double borderRadius;
//   final double width;
//   final double height;
//   final Color color;

//   const CarRentGradientButton({
//     super.key,
//     required this.buttonText,
//     required this.onPressed,
//     this.borderRadius = 12.0, // Default border radius
//     this.width = 395, // Default width
//     this.height = 55,
//     this.color = const Color(0xFF32D34B), // Default height
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: width,
//       height: height,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             color, // Bolder green
//             // Darker green for contrast
//             color
//           ],
//           begin: Alignment.bottomLeft,
//           end: Alignment.topRight,
//         ),
//         borderRadius: BorderRadius.circular(borderRadius),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.3),
//             spreadRadius: 1,
//             blurRadius: 6,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(borderRadius),
//           ),
//           backgroundColor: Colors.transparent,
//           shadowColor: Colors.transparent,
//           padding: EdgeInsets.zero, // Remove default padding
//         ),
//         child: Center(
//           child: Text(
//             buttonText,
//             style: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w600,
//               color: AppPalette.onPrimary,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:car_rent/core/theme/app_pallete.dart';

// class CarRentGradientButton extends StatelessWidget {
//   final String buttonText;
//   final VoidCallback onPressed;
//   final double borderRadius;
//   final double width;
//   final double height;
//   final Color color;
//   final bool isActive; // Add a boolean to check if the button is active or not

//   const CarRentGradientButton({
//     super.key,
//     required this.buttonText,
//     required this.onPressed,
//     this.borderRadius = 12.0, // Default border radius
//     this.width = 395, // Default width
//     this.height = 55,
//     this.color = const Color(0xFF32D34B), // Default height
//     this.isActive = true, // Default to active
//   });

//   @override
//   Widget build(BuildContext context) {
//     // Set inactive color (e.g., light gray or muted green)
//     Color inactiveColor =
//         isActive ? color : Colors.grey[400]!; // Muted color for inactive state
//     Color textColor = isActive
//         ? AppPalette.onPrimary
//         : Colors.grey[600]!; // Dimmed text color
//     Color borderColor = isActive
//         ? color
//         : Colors.grey[300]!; // Subtle border color for inactive state
//     double shadowOpacity = isActive ? 0.3 : 0.1; // Lighter shadow when inactive

//     return Container(
//       width: width,
//       height: height,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             inactiveColor, // Use the inactive color when button is inactive
//             inactiveColor, // Same color for both gradient ends
//           ],
//           begin: Alignment.bottomLeft,
//           end: Alignment.topRight,
//         ),
//         borderRadius: BorderRadius.circular(borderRadius),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(
//                 shadowOpacity), // Lighter shadow for inactive state
//             spreadRadius: 1,
//             blurRadius: 6,
//             offset: const Offset(0, 4),
//           ),
//         ],
//         border:
//             Border.all(color: borderColor), // Subtle border color when inactive
//       ),
//       child: ElevatedButton(
//         onPressed: isActive ? onPressed : null, // Disable button if not active
//         style: ElevatedButton.styleFrom(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(borderRadius),
//           ),
//           backgroundColor: Colors.transparent,
//           shadowColor: Colors.transparent,
//           padding: EdgeInsets.zero, // Remove default padding
//         ),
//         child: Center(
//           child: Text(
//             buttonText,
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w600,
//               color: textColor, // Dimmed text color for inactive state
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:car_rent/core/theme/app_pallete.dart';

class CarRentGradientButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final double borderRadius;
  final double width;
  final double height;
  final Color color;
  final bool isActive;

  const CarRentGradientButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.borderRadius = 12.0,
    this.width = 395,
    this.height = 55,
    this.color = const Color(0xFF32D34B),
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    Color inactiveStartColor = Colors.grey[400]!;
    Color inactiveEndColor = Colors.grey[300]!;
    Color textColor = isActive
        ? AppPalette.onPrimary
        : Colors.grey[600]!; // Dimmed text color
    Color borderColor = isActive ? color : Colors.grey[300]!;
    double shadowOpacity = isActive ? 0.3 : 0.05; // Minimal shadow for inactive

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isActive
              ? [color, color.withOpacity(0.9)]
              : [inactiveStartColor, inactiveEndColor],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(shadowOpacity),
            spreadRadius: isActive ? 1 : 0.5,
            blurRadius: isActive ? 6 : 3,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: borderColor),
      ),
      child: ElevatedButton(
        onPressed: isActive ? onPressed : null,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.zero,
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}

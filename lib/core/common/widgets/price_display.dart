import 'package:flutter/material.dart';

class PriceDisplay extends StatelessWidget {
  final String price;
  final String currencyLabel;
  final double currencyFontSize;
  final double priceFontSize;
  final FontWeight priceFontWeight;
  final Color textColor;
  final bool showPerHour; // New parameter for showing "/hour"
  final double perHourFontSize; // Customizable font size for /hour
  final bool lineThrough;

  const PriceDisplay({
    Key? key,
    required this.price,
    this.currencyLabel = "(ETB)", // Default value for currency
    this.currencyFontSize = 12, // Default size for currency
    this.priceFontSize = 16, // Default size for price
    this.priceFontWeight = FontWeight.bold, // Default weight for price
    this.textColor = Colors.black87, // Default color
    this.showPerHour = false, // Default: don't show /hour
    this.perHourFontSize = 14, // Default smaller font size for /hour
    this.lineThrough = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: currencyLabel, // Currency label (e.g., "ETB")
            style: TextStyle(
              fontSize: currencyFontSize, // Customizable size
              fontWeight: FontWeight.normal,
              color: textColor,
            ),
          ),
          TextSpan(
            text: " $price", // Price value
            style: TextStyle(
                fontSize: priceFontSize, // Customizable size
                fontWeight: priceFontWeight, // Customizable weight
                color: textColor,
                decoration: lineThrough ? TextDecoration.lineThrough : null),
          ),
          if (showPerHour) ...[
            TextSpan(
              text: " /hour", // The "/hour" text
              style: TextStyle(
                fontSize: perHourFontSize, // Smaller font size
                fontWeight: FontWeight.normal,
                color: textColor.withOpacity(0.6), // Lighter color
              ),
            ),
          ]
        ],
      ),
    );
  }
}

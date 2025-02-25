import 'package:car_rent/core/common/constants.dart';
import 'package:car_rent/core/common/widgets/price_display.dart';
import 'package:flutter/material.dart';

class PaymentDetails extends StatelessWidget {
  final DateTime initialdatetime;
  final DateTime returndatetime;
  final double distancefee;
  final double priceperhour;

  const PaymentDetails({
    Key? key,
    required this.initialdatetime,
    required this.returndatetime,
    required this.distancefee,
    required this.priceperhour,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final duration = returndatetime.difference(initialdatetime);
    final hours = duration.inHours;
    final days = duration.inDays;
    final totalHours = (duration.inMinutes / 60).ceil();
    final tripFee = totalHours * priceperhour + distancefee;
    final rentalfee = totalHours * priceperhour;

    final discount =
        0.0; // Example value, you can calculate based on conditions
    final totalAmount = tripFee - discount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Payment Details",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              // Duration and Cost
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "$totalHours hours, ($totalHours  X $priceperhour )",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                  PriceDisplay(
                    price: "${rentalfee.toStringAsFixed(2)}",
                    priceFontSize: 15,
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Trip Fee
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Distance fee (${(distancefee / Constants.perkmprice).toStringAsFixed(2)}. X ${Constants.perkmprice})",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                  PriceDisplay(
                    price: "${distancefee.toStringAsFixed(2)}",
                    priceFontSize: 15,
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Discount
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Discount",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                  PriceDisplay(
                    price: "${discount.toStringAsFixed(2)}",
                    priceFontSize: 15,
                  ),
                ],
              ),

              const Divider(thickness: 1.0, color: Colors.black26),

              // Total Amount
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total amount",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  PriceDisplay(
                    price: "${totalAmount.toStringAsFixed(2)}",
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:car_rent/features/car/presentation/widgets/car_rent_gradient_button.dart';
import 'package:car_rent/features/car/presentation/widgets/get_approved_widget.dart';
import 'package:flutter/material.dart';
import 'package:car_rent/core/theme/app_pallete.dart';
import 'package:car_rent/features/car/presentation/widgets/payment_details.dart';

class TripDetailsPage extends StatelessWidget {
  const TripDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Trip Details',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black87),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCarImage(),
                  const SizedBox(width: 16.0),
                  _buildCarDetails(),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Trip date & Time",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 227, 249, 228),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildDateTimeColumn("10 Aug, Thu", "10:00 AM"),
                  const Icon(Icons.arrow_forward, color: Colors.green),
                  _buildDateTimeColumn("17 Aug, Thu", "5:00 AM"),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Pickup & Return",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.location_on,
                    color: AppPalette.primaryColor, size: 24),
                const SizedBox(width: 8),
                const Text(
                  "Addis Ababa, CA 911212",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            PaymentDetails(),
          ],
        ),
      ),
    );
  }

  Widget _buildCarImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        height: 100,
        width: 100,
        child: Image.asset(
          'assets/images/tesla.png',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey.shade300,
              child:
                  const Icon(Icons.broken_image, size: 50, color: Colors.grey),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCarDetails() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Model Name
          const Text(
            'Tesla Model X',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8.0),
          // Rating and Trips Info
          Row(
            children: [
              const Icon(Icons.star, color: AppPalette.primaryColor, size: 20),
              const SizedBox(width: 4.0),
              const Text(
                '5.00',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(width: 12.0),
              const Text(
                '100 trips',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          // Price
          Row(
            children: [
              const Icon(Icons.attach_money, size: 20, color: Colors.green),
              const SizedBox(width: 4.0),
              const Text(
                '\$122/hour',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDateTimeColumn(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}

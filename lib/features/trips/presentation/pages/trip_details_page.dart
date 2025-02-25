import 'package:car_rent/core/common/entities/trip.dart';
import 'package:car_rent/core/common/widgets/custom_image.dart';
import 'package:car_rent/core/utils/date_time_utils.dart';
import 'package:car_rent/features/car/presentation/widgets/car_rent_gradient_button.dart';
import 'package:car_rent/features/car/presentation/widgets/get_approved_widget.dart';
import 'package:flutter/material.dart';
import 'package:car_rent/core/theme/app_pallete.dart';
import 'package:car_rent/features/car/presentation/widgets/payment_details.dart';

class TripDetailsPage extends StatelessWidget {
  final Trip trip;
  const TripDetailsPage({Key? key, required this.trip}) : super(key: key);

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
                  // _buildDateTimeColumn("10 Aug, Thu", "10:00 AM"),
                  _buildDateTimeColumn(
                      "${trip.startTime.day} ${DateTimeUtils.getMonthName(trip.startTime.month)},${DateTimeUtils.getWeekName(trip.startTime)}",
                      "${DateTimeUtils.getFormattedTime(trip.startTime)}"),
                  const Icon(Icons.arrow_forward, color: Colors.green),
                  // _buildDateTimeColumn("17 Aug, Thu", "5:00 AM"),
                  _buildDateTimeColumn(
                      "${trip.endTime.day} ${DateTimeUtils.getMonthName(trip.endTime.month)},${DateTimeUtils.getWeekName(trip.endTime)}",
                      "${DateTimeUtils.getFormattedTime(trip.endTime)}"),
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
                const Icon(Icons.location_on,
                    color: AppPalette.primaryColor, size: 24),
                const SizedBox(width: 8),
                Text(
                  trip.pickupLocation,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // PaymentDetails(),
          ],
        ),
      ),
    );
  }

  Widget _buildCarImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        height: 110,
        width: 110,
        child: CustomImage(
            imageUrl: trip.vehicle.gallery![0], height: 110, width: 110),
      ),
    );
  }

  Widget _buildCarDetails() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Model Name
          Text(
            "${trip.vehicle.model} ${trip.vehicle.brand}",
            style: const TextStyle(
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
              Text(
                trip.vehicle.rating?.toStringAsFixed(2) ?? "No rating",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(width: 12.0),
              Text(
                trip.vehicle.numberOfTrips.toString(),
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          // Price
          Row(
            children: [
              const Icon(Icons.attach_money, size: 20, color: Colors.green),
              const SizedBox(width: 4.0),
              Text(
                "${trip.vehicle.pricePerHour}/hour",
                style: const TextStyle(
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

import 'package:car_rent/features/car/presentation/pages/select_pickup_and_return.dart';
import 'package:flutter/material.dart';
import 'package:car_rent/core/theme/app_pallete.dart';
import 'package:car_rent/features/car/presentation/pages/select_trip_date_and_time.dart';

class TripOptions extends StatelessWidget {
  const TripOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Trip Dates",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SelectTripDateAndTime(),
                ),
              );
            },
            child: _buildOptionRow(
                Icons.calendar_today, "Any Time", "Add dates >"),
          ),
        ),
        const SizedBox(height: 32.0),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Pickup & Return",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SelectPickupAndReturn(),
                ),
              );
            },
            child: _buildOptionRow(
                Icons.location_on, "Pickup and Return", "Change >"),
          ),
        ),
      ],
    );
  }

  Widget _buildOptionRow(IconData icon, String title, String action) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: AppPalette.primaryColor),
              const SizedBox(width: 8.0),
              Text(title, style: const TextStyle(fontSize: 16)),
            ],
          ),
          Text(
            action,
            style: const TextStyle(
                fontSize: 14,
                color: AppPalette.primaryColor,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

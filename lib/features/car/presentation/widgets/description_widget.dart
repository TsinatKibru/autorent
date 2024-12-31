import 'package:flutter/material.dart';
import 'package:car_rent/core/theme/app_pallete.dart';

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Description Section
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Description",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
            "Curabitur non nulla sit amet nisl tempus convallis quis ac lectus.",
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ),
        const SizedBox(height: 24.0),

        // Car Basics Section
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Car Basics",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        const SizedBox(height: 16.0),

        // Horizontally Scrollable Cards
        SizedBox(
          height: 120, // Card height
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: const [
              _CarBasicsCard(
                icon: Icons.battery_charging_full_outlined,
                label: "Battery",
                value: "100 kWh",
              ),
              _CarBasicsCard(
                icon: Icons.event_seat,
                label: "Capacity",
                value: "5 seats",
              ),
              _CarBasicsCard(
                icon: Icons.door_sliding,
                label: "Entrance",
                value: "4 doors",
              ),
              _CarBasicsCard(
                icon: Icons.speed,
                label: "Top Speed",
                value: "250 km/h",
              ),
              _CarBasicsCard(
                icon: Icons.settings,
                label: "Transmission",
                value: "Automatic",
              ),
              _CarBasicsCard(
                icon: Icons.local_gas_station,
                label: "Engine",
                value: "Electric",
              ),
            ],
          ),
        ),
        const SizedBox(height: 24.0),

        // Insurance Section
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Insurance",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: GestureDetector(
            onTap: () {
              // Implement read more functionality
            },
            child: _buildOptionRow(
              Icons.shield,
              "Insurance via Travelers",
              "Read More >",
            ),
          ),
        ),
        const SizedBox(height: 24.0),

        // Cancellation Policy Section
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Cancellation Policy",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: _buildOptionRow(
            Icons.cancel,
            "Free cancellation 5 days before Trip",
            "",
          ),
        ),
        const SizedBox(height: 16.0),
        // Rating and Reviews Section
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Rating and Reviews",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        // Display ratings
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Icon(Icons.star, color: AppPalette.primaryColor, size: 20),
              const SizedBox(width: 4.0),
              const Text(
                "5.00",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8.0),
              const Text(
                "• 139 reviews",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),

        // Reviews Section

        // Add these widgets below the "View Reviews" section

// Add Ratings Details with Lines
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: const [
              _RatingDetailRow(label: "Cleanliness", value: "4"),
              SizedBox(height: 8.0),
              _RatingDetailRow(label: "Maintenance", value: "5"),
              SizedBox(height: 8.0),
              _RatingDetailRow(label: "Comfort", value: "5"),
              SizedBox(height: 8.0),
              _RatingDetailRow(label: "Location", value: "4.5"),
            ],
          ),
        ),
      ],
    );
  }
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
        Flexible(
          child: Text(
            action,
            style: const TextStyle(
              fontSize: 14,
              color: AppPalette.primaryColor,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.visible, // Allow text to wrap
            softWrap: true, // Enable text wrapping
          ),
        ),
      ],
    ),
  );
}

class _RatingDetailRow extends StatelessWidget {
  const _RatingDetailRow({
    required this.label,
    required this.value,
    Key? key,
  }) : super(key: key);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Divider(
              color: AppPalette.primaryColor,
              thickness: 5,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _CarBasicsCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _CarBasicsCard({
    Key? key,
    required this.icon,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100, // Card width
      margin: const EdgeInsets.only(right: 12.0),
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: AppPalette.primaryColor),
          const SizedBox(height: 8.0),
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Colors.black54),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4.0),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

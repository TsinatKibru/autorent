import 'package:car_rent/core/theme/app_pallete.dart';
import 'package:car_rent/features/navigation/presentation/widgets/bottom_navigation_bar_widget.dart';
import 'package:car_rent/features/trips/presentation/pages/trip_details_page.dart';
import 'package:flutter/material.dart';

class TripsPage extends StatelessWidget {
  // Mock data for trips
  final List<Map<String, String>> trips = [
    {
      'model': 'Tesla Model X',
      'status': 'On the way',
      'arrivalTime': '3 mins',
      'image': 'assets/images/tesla.png',
      'name': 'John Doe',
      'phone': '+1 123-456-7890',
    },
    {
      'model': 'BMW Series 3',
      'status': 'Waiting',
      'arrivalTime': '5 mins',
      'image': 'assets/images/tesla2.png',
      'name': 'Jane Smith',
      'phone': '+1 987-654-3210',
    },
    {
      'model': 'Toyota Corolla',
      'status': 'Completed',
      'arrivalTime': '',
      'image': 'assets/images/tesla9.png',
      'name': 'Mark Johnson',
      'phone': '+1 555-555-5555',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Align(
          alignment: Alignment.center,
          child: const Text(
            'Your Trips',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8.0),
        itemCount: trips.length,
        separatorBuilder: (context, index) => const SizedBox(
          height: 5,
        ),
        itemBuilder: (context, index) {
          final trip = trips[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.black12, // Border color
                  width: 0.5, // Border width
                  style: BorderStyle
                      .solid, // Border style: solid, dashed (custom implementations), or none
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCarImage(trip['image']!),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildCarDetails(
                          model: trip['model']!,
                          status: trip['status']!,
                          arrivalTime: trip['arrivalTime']!,
                        ),
                        const SizedBox(height: 8.0),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.message,
                            color: AppPalette.primaryColor),
                        onPressed: () {
                          // Navigate to message page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BottomNavigationBarWidget(
                                initialIndex: 0,
                              ),
                            ),
                          );
                        },
                      ),
                      _buildDetailsButton(context),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCarImage(String imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        height: 110,
        width: 110,
        child: Image.asset(
          imagePath,
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

  Widget _buildCarDetails({
    required String model,
    required String status,
    required String arrivalTime,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            model,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            status,
            style: TextStyle(
              fontSize: 16,
              color: status == 'Completed' ? Colors.green : Colors.orange,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (arrivalTime.isNotEmpty) ...[
            const SizedBox(height: 8.0),
            Row(
              children: [
                const Icon(Icons.access_time, size: 20, color: Colors.grey),
                const SizedBox(width: 4.0),
                Text(
                  arrivalTime,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailsButton(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: AppPalette.primaryColor, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      onPressed: () {
        // Proceed to payment logic
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TripDetailsPage(),
          ),
        );
      },
      child: const Text(
        "Details",
        style: TextStyle(
          fontSize: 14,
          color: AppPalette.primaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

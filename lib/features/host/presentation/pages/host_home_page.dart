import 'package:car_rent/features/host/presentation/widgets/host_motivation.dart';
import 'package:car_rent/features/host/presentation/widgets/my_cars.dart';
import 'package:car_rent/features/host/presentation/widgets/my_orders.dart';
import 'package:flutter/material.dart';
import 'package:car_rent/core/theme/app_pallete.dart';
import 'package:car_rent/features/car/presentation/widgets/car_rent_gradient_button.dart';
import 'package:car_rent/features/car/presentation/widgets/filtered_cars.dart';
import 'package:car_rent/features/car/presentation/widgets/most_popular_cars.dart';
import 'package:car_rent/features/car/presentation/widgets/search_bar_with_filter.dart';
import 'package:car_rent/features/car/presentation/widgets/top_brands_section.dart';
import 'package:car_rent/features/car/presentation/widgets/top_rated_cars.dart';

class HostHomePage extends StatefulWidget {
  const HostHomePage({Key? key}) : super(key: key);

  @override
  _HostHomePageState createState() => _HostHomePageState();
}

class _HostHomePageState extends State<HostHomePage> {
  final TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  @override
  void dispose() {
    // Dispose of the TextEditingController
    searchController.dispose();
    super.dispose();
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Filter Options"),
          content: Text("Add filter options here."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left side: Icon and Text
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  color: Colors.black87,
                  size: 24,
                ),
                SizedBox(width: 8),
                Text(
                  "Location",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(width: 4),
                Icon(Icons.arrow_drop_down, color: AppPalette.primaryColor),
              ],
            ),
            // Right side: Network Image
            ClipOval(
              child: Image.network(
                'https://www.gravatar.com/avatar/2c7d99fe281ecd3bcd65ab915bac6dd5?s=250',
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row with Location and Profile Picture

            HostMotivation(),

            // Top Rated Cars Section

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: MyCars(),
            ),
            const SizedBox(height: 20),

            // Most Popular Cars Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: MyOrders(),
            ),
          ],
        ),
      ),
    );
  }
}

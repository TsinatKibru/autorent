import 'package:car_rent/features/car/presentation/widgets/filter_dialog.dart';
import 'package:car_rent/features/host/presentation/widgets/custom_app_bar.dart';
import 'package:car_rent/features/navigation/presentation/widgets/bottom_navigation_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:car_rent/features/car/presentation/widgets/car_rent_gradient_button.dart';
import 'package:car_rent/features/car/presentation/widgets/filtered_cars.dart';
import 'package:car_rent/features/car/presentation/widgets/most_popular_cars.dart';
import 'package:car_rent/features/car/presentation/widgets/search_bar_with_filter.dart';
import 'package:car_rent/features/car/presentation/widgets/top_brands_section.dart';
import 'package:car_rent/features/car/presentation/widgets/top_rated_cars.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  @override
  void dispose() {
    // Dispose of the TextEditingController
    searchController.dispose();
    super.dispose();
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows better height control
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom:
              MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
        ),
        child: FilterDialog(
          onSearch: (query) {
            setState(() {
              searchQuery = query;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text and Host & Earn Button Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Rent a Car anytime",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  CarRentGradientButton(
                    buttonText: "Host & Earn",
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) =>
                                BottomNavigationBarWidget(initialIndex: 4)),
                        (Route<dynamic> route) =>
                            false, // Removes all previous routes
                      );
                    },
                    width: 110,
                    height: 35,
                    borderRadius: 14,
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Search Bar with Filter
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SearchBarWithFilter(
                searchController: searchController,
                onSearch: (query) {
                  setState(() {
                    searchQuery = query;
                  });
                },
                onFilter: _showFilterDialog,
              ),
            ),
            const SizedBox(height: 10),

            // Filtered Cars Section

            // Top Brands Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TopBrandsSection(
                onBrandSelected: (brand) {
                  setState(() {
                    searchQuery = brand == "All" ? "" : brand;
                  });
                },
              ),
            ),

            FilteredCars(filter: searchQuery),
            const SizedBox(height: 3),

            // Top Rated Cars Section
            if (searchQuery.isEmpty) ...[
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: TopRatedCarsSection(),
              ),
              const SizedBox(height: 20),

              // Most Popular Cars Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: MostPopularCars(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

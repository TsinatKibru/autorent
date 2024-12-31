import 'package:car_rent/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class FilteredCars extends StatelessWidget {
  final String filter; // Add a filter parameter
  final List<Map<String, String>> cars = [
    {
      'image': 'assets/images/tesla3.png',
      'model': 'Tesla Model S',
      'availability': 'Available from August 3',
      'seats': '4 seats',
      'price': '\$130/hour',
    },
    {
      'image': 'assets/images/tesla4.png',
      'model': 'The BMW IX',
      'availability': 'Available from August 3',
      'seats': '4 seats',
      'price': '\$130/hour',
    },
    {
      'image': 'assets/images/tesla.png',
      'model': 'Tesla Model X',
      'availability': 'Available from August 2',
      'seats': '4 seats',
      'price': '\$122/hour',
    },
    {
      'image': 'assets/images/tesla2.png',
      'model': 'Tesla Model 3',
      'availability': 'Available from August 3',
      'seats': '4 seats',
      'price': '\$130/hour',
    },
  ];

  FilteredCars({Key? key, required this.filter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine filtered cars based on the filter parameter
    final filteredCars = filter.isEmpty
        ? []
        : filter.toLowerCase() == "all"
            ? cars
            : cars.where((car) {
                return car['model']!
                    .toLowerCase()
                    .contains(filter.toLowerCase());
              }).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (filteredCars.isEmpty)
            Center(
              child: Text(
                filter.isEmpty ? '' : 'No cars match your search.',
                style: TextStyle(
                    fontSize: filter.isEmpty ? 0 : 16, color: Colors.black54),
              ),
            ),
          ListView.builder(
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(), // Prevent inner scrolling
            shrinkWrap: true, // Allow the ListView to shrink within Column
            itemCount: filteredCars.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(18.0),
                          topRight: Radius.circular(18.0),
                        ),
                        child: Image.asset(
                          filteredCars[index]['image']!,
                          height: 190,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              filteredCars[index]['model']!,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: AppPalette.primaryColor,
                                  size: 19,
                                ),
                                const SizedBox(width: 4.0),
                                Text(
                                  "5.00",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          filteredCars[index]['availability']!,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.notifications,
                                  size: 16,
                                  color: AppPalette.primaryColor,
                                ),
                                const SizedBox(width: 4.0),
                                Text(
                                  filteredCars[index]['seats']!,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  size: 16,
                                  color: AppPalette.primaryColor,
                                ),
                                const SizedBox(width: 4.0),
                                Text(
                                  filteredCars[index]['price']!,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

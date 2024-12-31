import 'package:car_rent/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class MostPopularCars extends StatelessWidget {
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

  MostPopularCars({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title for the section
          Text(
            "Most Popular Cars",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12.0),

          // Scrollable list of car cards
          ListView.builder(
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(), // Prevent inner scrolling
            shrinkWrap: true, // Allow the ListView to shrink within Column
            itemCount: cars.length,
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
                      // Car image at the top with top-left and top-right border radius
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(18.0),
                          topRight: Radius.circular(18.0),
                        ),
                        child: Image.asset(
                          cars[index]['image']!,
                          height: 190,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 16.0),

                      // Car model and rating side by side
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              cars[index]['model']!,
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

                      // Availability Text
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          cars[index]['availability']!,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),

                      // Row with Seats and Price
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
                                  cars[index]['seats']!,
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
                                  cars[index]['price']!,
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

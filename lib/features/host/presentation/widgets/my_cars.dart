import 'package:car_rent/core/theme/app_pallete.dart';
import 'package:car_rent/features/car/presentation/pages/car_details_page.dart';
import 'package:car_rent/features/host/presentation/pages/create_vehicle_page.dart';
import 'package:flutter/material.dart';

class MyCars extends StatelessWidget {
  final List<Map<String, String>> cars = [
    {
      'image': 'assets/images/tesla.png', // Example image path
      'model': 'Tesla Model X',
      'availability': 'Available from August 2',
      'seats': '4 seats',
      'price': '\$122/hour',
    },
    {
      'image': 'assets/images/tesla2.png', // Example image path
      'model': 'Tesla Model 3',
      'availability': 'Available from August 3',
      'seats': '4 seats',
      'price': '\$130/hour',
    },
    {
      'image': 'assets/images/tesla3.png', // Example image path
      'model': 'Tesla Model S',
      'availability': 'Available from August 3',
      'seats': '4 seats',
      'price': '\$130/hour',
    },
    {
      'image': 'assets/images/tesla4.png', // Example image path
      'model': 'The BMW IX',
      'availability': 'Available from August 3',
      'seats': '4 seats',
      'price': '\$130/hour',
    },
    // Add more car data as needed
  ];

  MyCars({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title for the section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "My Cars",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateVehiclePage(),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Icon(Icons.add, color: AppPalette.primaryColor),
                    Text(
                      'Add New Car',
                      style: TextStyle(
                          color: AppPalette.primaryColor,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 12.0),

          // Scrollable list of car cards
          SizedBox(
            height: 230, // Height for the card container
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: cars.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CarDetailsPage(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Card(
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Container(
                        width: 200, // Width of each card
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                // Image
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(18.0),
                                      topRight: Radius.circular(18.0)),
                                  child: Image.asset(
                                    cars[index]['image']!,
                                    height: 130,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                // Heart Icon at top-right
                                Positioned(
                                  top: 8.0,
                                  right: 8.0,
                                  child: Icon(
                                    Icons.favorite,
                                    color: AppPalette.primaryColor,
                                    size: 24,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8.0),

                            // Car Model and Rating
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      Icon(Icons.star,
                                          color: AppPalette.primaryColor,
                                          size: 19),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                cars[index]['availability']!,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8.0),

                            // Row with Bell Icon, Seats, and Price
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.notifications,
                                          size: 16,
                                          color: AppPalette.primaryColor),
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
                                      Icon(Icons.access_time,
                                          size: 16,
                                          color: AppPalette.primaryColor),
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
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:car_rent/core/theme/app_pallete.dart';
import 'package:car_rent/features/car/presentation/pages/car_details_page.dart';
import 'package:car_rent/features/messaging/presentation/pages/message_page.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  final List<Map<String, String>> favoriteCars = [
    {
      'image': 'assets/images/tesla3.png',
      'model': 'Tesla Model S',
      'availability': 'Available now',
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
  ];

  FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("My Favorites"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: favoriteCars.isEmpty
            ? Center(
                child: Text(
                  "You have no favorite vehicles yet.",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: favoriteCars.length,
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
                          // Car image with a favorite icon
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(18.0),
                                  topRight: Radius.circular(18.0),
                                ),
                                child: Image.asset(
                                  favoriteCars[index]['image']!,
                                  height: 190,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 12.0,
                                right: 12.0,
                                child: GestureDetector(
                                  onTap: () {
                                    // Add functionality to unfavorite the vehicle here
                                  },
                                  child: Icon(
                                    Icons.favorite,
                                    color: AppPalette.primaryColor,
                                    size: 28.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12.0),

                          // Car details
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  favoriteCars[index]['model']!,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  favoriteCars[index]['availability']!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.airline_seat_recline_normal,
                                          size: 16,
                                          color: AppPalette.primaryColor,
                                        ),
                                        const SizedBox(width: 4.0),
                                        Text(
                                          favoriteCars[index]['seats']!,
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
                                          Icons.attach_money,
                                          size: 16,
                                          color: AppPalette.primaryColor,
                                        ),
                                        const SizedBox(width: 4.0),
                                        Text(
                                          favoriteCars[index]['price']!,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12.0),
                              ],
                            ),
                          ),

                          // Buttons for actions
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppPalette.primaryColor,
                                  ),
                                  onPressed: () {
                                    // Proceed to payment logic
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CarDetailsPage(),
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.directions_car,
                                    color: Colors.white,
                                  ),
                                  label: Text(
                                    "Book Now",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Proceed to payment logic
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MessagePage(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Contact Host",
                                    style: TextStyle(
                                      color: AppPalette.primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8.0),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

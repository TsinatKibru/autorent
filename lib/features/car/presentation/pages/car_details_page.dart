import 'package:car_rent/core/theme/app_pallete.dart';
import 'package:car_rent/features/car/presentation/widgets/book_now.dart';
import 'package:car_rent/features/car/presentation/widgets/car_images_carousel.dart';
import 'package:car_rent/features/car/presentation/widgets/car_rent_gradient_button.dart';
import 'package:car_rent/features/car/presentation/widgets/description_widget.dart';
import 'package:car_rent/features/car/presentation/widgets/guide_lines.dart';
import 'package:car_rent/features/car/presentation/widgets/host_details_card.dart';
import 'package:car_rent/features/car/presentation/widgets/request_to_book.dart';
import 'package:car_rent/features/car/presentation/widgets/reviews.dart';
import 'package:car_rent/features/car/presentation/widgets/trip_options.dart';
import 'package:flutter/material.dart';

class CarDetailsPage extends StatefulWidget {
  CarDetailsPage({Key? key}) : super(key: key);

  @override
  _CarDetailsPageState createState() => _CarDetailsPageState();
}

class _CarDetailsPageState extends State<CarDetailsPage> {
  final List<String> carImages = [
    'assets/images/tesla4.png',
    'assets/images/tesla3.png',
    'assets/images/tesla.png',
  ]; // Replace with actual image paths

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Car Details"),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarImageCarousel(carImages: carImages),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tesla Model X",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        "\$120/hour",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
                  child: Row(
                    children: [
                      Icon(Icons.star,
                          color: AppPalette.primaryColor, size: 20),
                      SizedBox(width: 4.0),
                      Text(
                        "5.00",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        "• 139 trips",
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24.0),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Host",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
                const HostDetails(),
                const SizedBox(height: 24.0),
                const TripOptions(),
                const SizedBox(height: 30.0),
                const DescriptionWidget(),
                const SizedBox(height: 30),
                const ReviewsSection(),
                const SizedBox(height: 30),
                const GuideLines(),
                const SizedBox(height: 120),
              ],
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.15,
            minChildSize: 0.03,
            maxChildSize: 0.15,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      spreadRadius: 5,
                      offset: Offset(0, -5),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            width: 40,
                            height: 5,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "\$120",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "\$150",
                                  style: TextStyle(
                                    fontSize: 16,
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.white60,
                                  ),
                                ),
                              ],
                            ),
                            CarRentGradientButton(
                              buttonText: "Book Now",
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RequestToBook(),
                                  ),
                                );
                                // Add booking logic here
                              },
                              borderRadius: 10.0,
                              width: 150.0,
                              height: 50.0,
                            ),
                          ],
                        ),
                      ],
                    ),
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

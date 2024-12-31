// import 'package:car_rent/core/theme/app_pallete.dart';
// import 'package:car_rent/features/car/presentation/pages/car_details_page.dart';
// import 'package:flutter/material.dart';

// class TopRatedCarsSection extends StatelessWidget {
//   final List<Map<String, String>> cars = [
//     {
//       'image': 'assets/images/tesla.png', // Example image path
//       'model': 'Tesla Model X',
//       'availability': 'Available from August 2',
//       'seats': '4 seats',
//       'price': '\$122/hour',
//     },
//     {
//       'image': 'assets/images/tesla2.png', // Example image path
//       'model': 'Tesla Model 3',
//       'availability': 'Available from August 3',
//       'seats': '4 seats',
//       'price': '\$130/hour',
//     },
//     {
//       'image': 'assets/images/tesla3.png', // Example image path
//       'model': 'Tesla Model S',
//       'availability': 'Available from August 3',
//       'seats': '4 seats',
//       'price': '\$130/hour',
//     },
//     {
//       'image': 'assets/images/tesla4.png', // Example image path
//       'model': 'The BMW IX',
//       'availability': 'Available from August 3',
//       'seats': '4 seats',
//       'price': '\$130/hour',
//     },
//     // Add more car data as needed
//   ];

//   TopRatedCarsSection({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Title for the section
//           Text(
//             "Top Rated Cars",
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.black87,
//             ),
//           ),
//           const SizedBox(height: 12.0),

//           // Scrollable list of car cards
//           SizedBox(
//             height: 230, // Height for the card container
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: cars.length,
//               itemBuilder: (context, index) {
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => CarDetailsPage(),
//                       ),
//                     );
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.only(right: 16.0),
//                     child: Card(
//                       elevation: 4.0,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12.0),
//                       ),
//                       child: Container(
//                         width: 200, // Width of each card
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Stack(
//                               children: [
//                                 // Image
//                                 ClipRRect(
//                                   borderRadius: BorderRadius.only(
//                                       topLeft: Radius.circular(18.0),
//                                       topRight: Radius.circular(18.0)),
//                                   child: Image.asset(
//                                     cars[index]['image']!,
//                                     height: 130,
//                                     width: double.infinity,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                                 // Heart Icon at top-right
//                                 Positioned(
//                                   top: 8.0,
//                                   right: 8.0,
//                                   child: Icon(
//                                     Icons.favorite,
//                                     color: AppPalette.primaryColor,
//                                     size: 24,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 8.0),

//                             // Car Model and Rating
//                             Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 10.0),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                     cars[index]['model']!,
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.black87,
//                                     ),
//                                   ),
//                                   Row(
//                                     children: [
//                                       Icon(Icons.star,
//                                           color: AppPalette.primaryColor,
//                                           size: 19),
//                                       const SizedBox(width: 4.0),
//                                       Text(
//                                         "5.00",
//                                         style: TextStyle(
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.bold,
//                                           color: Colors.black54,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(height: 8.0),

//                             // Availability Text
//                             Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 10.0),
//                               child: Text(
//                                 cars[index]['availability']!,
//                                 style: TextStyle(
//                                   fontSize: 15,
//                                   color: Colors.black54,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 8.0),

//                             // Row with Bell Icon, Seats, and Price
//                             Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 10.0),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Icon(Icons.notifications,
//                                           size: 16,
//                                           color: AppPalette.primaryColor),
//                                       const SizedBox(width: 4.0),
//                                       Text(
//                                         cars[index]['seats']!,
//                                         style: TextStyle(
//                                           fontSize: 12,
//                                           color: Colors.black54,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   Row(
//                                     children: [
//                                       Icon(Icons.access_time,
//                                           size: 16,
//                                           color: AppPalette.primaryColor),
//                                       const SizedBox(width: 4.0),
//                                       Text(
//                                         cars[index]['price']!,
//                                         style: TextStyle(
//                                           fontSize: 12,
//                                           color: Colors.black54,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:car_rent/core/common/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:car_rent/core/theme/app_pallete.dart';
import 'package:car_rent/features/car/presentation/bloc/vehicle_bloc.dart';
import 'package:car_rent/features/car/presentation/pages/car_details_page.dart';

class TopRatedCarsSection extends StatelessWidget {
  const TopRatedCarsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title for the section
          Text(
            "Top Rated Cars",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12.0),

          // Scrollable list of car cards
          SizedBox(
            height: 230,
            child: BlocBuilder<VehicleBloc, VehicleState>(
              builder: (context, state) {
                if (state is VehicleLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is VehicleLoadSuccess) {
                  final cars = state
                      .vehicles; // Assuming `vehicles` is a list of vehicle data
                  if (cars.isEmpty) {
                    return const Center(
                      child: Text(
                        "No top-rated cars available.",
                        style: TextStyle(color: Colors.black54),
                      ),
                    );
                  }
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: cars.length,
                    itemBuilder: (context, index) {
                      final car = cars[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  // CarDetailsPage(car: car),
                                  CarDetailsPage(), // Pass car data
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
                              width: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      CustomImage(
                                        imageUrl: car
                                            .gallery![1], // Pass the image URL
                                        height: 130,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(18.0),
                                          topRight: Radius.circular(18.0),
                                        ),
                                        loadingIndicator:
                                            null, // Shimmer effect will be used by default

                                        showLoadingProgress:
                                            true, // Show shimmer loading progress
                                        // Custom padding for the image
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          car.model, // Assuming the vehicle has a model field
                                          style: const TextStyle(
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
                                              car.rating!.toStringAsFixed(2),
                                              style: const TextStyle(
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Text(
                                      // car.available, // Assuming the vehicle has an availability field
                                      "Available from August 2",
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),

                                  // Row with Bell Icon, Seats, and Price
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
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
                                              "${car.seatingCapacity} seats", // Assuming the vehicle has a seats field
                                              style: const TextStyle(
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
                                              '${car.pricePerHour.toString()} /hour',
                                              style: const TextStyle(
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
                  );
                } else if (state is VehicleFailure) {
                  return Center(
                    child: Text(
                      "Failed to load vehicles: ${state.message}",
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }
                return const Center(child: Text("No data available."));
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:car_rent/core/common/widgets/custom_image.dart';
import 'package:car_rent/core/theme/app_pallete.dart';
import 'package:car_rent/core/utils/show_snackbar.dart';
import 'package:car_rent/features/car/presentation/bloc/vehicle_bloc.dart';
import 'package:car_rent/features/car/presentation/pages/car_details_page.dart';
import 'package:car_rent/features/host/presentation/pages/create_vehicle_page.dart';
import 'package:car_rent/features/host/presentation/widgets/shimmer_loading_list.dart';
import 'package:car_rent/features/host/presentation/widgets/update_vehicle_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class MyCars extends StatefulWidget {
  final bool activeowner;

  MyCars({Key? key, required this.activeowner}) : super(key: key);

  @override
  State<MyCars> createState() => _MyCarsState();
}

class _MyCarsState extends State<MyCars> {
  @override
  void initState() {
    super.initState();

    // Trigger the initial fetch for top-rated vehicles
  }

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
              const Text(
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
                      builder: (context) => const CreateVehiclePage(),
                    ),
                  );
                },
                child: const Row(
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
            child: BlocBuilder<VehicleBloc, VehicleState>(
              builder: (context, state) {
                if (state is CurrentUserVehiclesLoading) {
                  return const ShimmerLoadingList();
                } else if (state is CurrentUserVehiclesLoadSuccess) {
                  final cars = state.vehicles;
                  if (cars.isEmpty) {
                    return const Center(
                      child: Text(
                        "No Cars Registered.",
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
                          Navigator.push(context, UpdateVehiclePage.route(car));
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
                                        imageUrl: car.gallery![0],
                                        height: 130,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(12.0),
                                          topRight: Radius.circular(12.0),
                                        ),
                                        showLoadingProgress: true,
                                      ),
                                      const Positioned(
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
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          car.model,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            const Icon(Icons.star,
                                                color: AppPalette.primaryColor,
                                                size: 18),
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
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Text(
                                      car.available
                                          ? "Currently available"
                                          : "Currently Unavailable",
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(Icons.notifications,
                                                size: 16,
                                                color: AppPalette.primaryColor),
                                            const SizedBox(width: 4.0),
                                            Text(
                                              "${car.seatingCapacity} seats",
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Icon(Icons.money,
                                                size: 16,
                                                color: AppPalette.primaryColor),
                                            const SizedBox(width: 4.0),
                                            Text(
                                              "${car.pricePerHour}/hour",
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
                } else if (state is CurrentUserVehiclesFailure) {
                  showSnackbar(context, state.message);
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

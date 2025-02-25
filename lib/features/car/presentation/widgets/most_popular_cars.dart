import 'package:car_rent/core/common/widgets/custom_image.dart';
import 'package:car_rent/core/theme/app_pallete.dart';
import 'package:car_rent/core/utils/show_snackbar.dart';
import 'package:car_rent/features/car/presentation/bloc/most_popular_vehicle_bloc.dart';
import 'package:car_rent/features/car/presentation/bloc/vehicle_bloc.dart';
import 'package:car_rent/features/car/presentation/pages/car_details_page.dart';
import 'package:car_rent/features/host/presentation/widgets/shimmer_loading_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MostPopularCars extends StatefulWidget {
  MostPopularCars({Key? key}) : super(key: key);

  @override
  State<MostPopularCars> createState() => _MostPopularCarsState();
}

class _MostPopularCarsState extends State<MostPopularCars> {
  late ScrollController _scrollController;
  int _currentPage = 1;
  final int _limit = 5;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();

    context.read<MostPopularVehicleBloc>().add(FetchMostPopularVehiclesEvent(
          page: _currentPage,
          limit: _limit,
        ));

    // Add scroll listener for pagination
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      print("label: ${_currentPage}");
      final currentState = context.read<MostPopularVehicleBloc>().state;
      if (currentState is MostPopularVehicleLoadSuccess &&
          currentState.hasMore) {
        _currentPage++;

        context
            .read<MostPopularVehicleBloc>()
            .add(FetchMostPopularVehiclesEvent(
              page: _currentPage,
              limit: _limit,
            ));
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MostPopularVehicleBloc, MostPopularVehicleState>(
      builder: (context, state) {
        // print("state of mostpopularpage :${state}");
        if (state is MostPopularVehicleLoading) {
          return const ShimmerLoadingList(
            itemCount: 1,
            cardWidth: 350,
            borderRadius: 8,
          );
        } else if (state is MostPopularVehicleLoadSuccess) {
          final cars = state.vehicles;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title for the section

                const Text(
                  "Most Popular Cars",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12.0),

                // Scrollable list of car cards
                SizedBox(
                  height: 500,
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.zero,
                    // Prevent inner scrolling
                    shrinkWrap:
                        true, // Allow the ListView to shrink within Column
                    itemCount: cars.length,
                    itemBuilder: (context, index) {
                      final car = cars[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CarDetailsPage(
                                vehicle: car,
                              ),
                            ),
                          );
                        },
                        child: Padding(
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
                                CustomImage(
                                  imageUrl: car.gallery![0],
                                  height: 190,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(18.0),
                                    topRight: Radius.circular(18.0),
                                  ),
                                  showLoadingProgress: true,
                                ),
                                const SizedBox(height: 16.0),

                                // Car model and rating side by side
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
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
                                      const Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: AppPalette.primaryColor,
                                            size: 19,
                                          ),
                                          SizedBox(width: 4.0),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    car.available
                                        ? "Avaialble "
                                        : "Unavailable",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8.0),

                                // Row with Seats and Price
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.airline_seat_recline_normal,
                                            size: 16,
                                            color: AppPalette.primaryColor,
                                          ),
                                          const SizedBox(width: 4.0),
                                          Text(
                                            car.seatingCapacity.toString(),
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.money_outlined,
                                            size: 16,
                                            color: AppPalette.primaryColor,
                                          ),
                                          const SizedBox(width: 4.0),
                                          Text(
                                            "${car.pricePerHour.toStringAsFixed(2)}/hour",
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
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          );
        } else if (state is MostPopularVehicleFailure) {
          showSnackbar(context, state.message);
        }
        return const Center(child: Text("No data available."));
      },
    );
  }
}

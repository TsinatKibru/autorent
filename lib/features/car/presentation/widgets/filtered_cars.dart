import 'package:car_rent/core/common/widgets/custom_image.dart';
import 'package:car_rent/core/common/widgets/price_display.dart';
import 'package:car_rent/core/theme/app_pallete.dart';
import 'package:car_rent/core/utils/show_snackbar.dart';
import 'package:car_rent/features/car/presentation/pages/car_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:car_rent/features/car/presentation/bloc/vehicle_bloc.dart';

class FilteredCars extends StatefulWidget {
  final String filter;

  const FilteredCars({Key? key, required this.filter}) : super(key: key);

  @override
  State<FilteredCars> createState() => _FilteredCarsState();
}

class _FilteredCarsState extends State<FilteredCars> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  final int _limit = 10;

  @override
  void initState() {
    super.initState();

    // Initial search event, only if the filter is not empty
    if (widget.filter.trim().isNotEmpty) {
      context.read<VehicleBloc>().add(SearchVehiclesEvent(
            query: widget.filter,
            page: _currentPage,
            limit: _limit,
          ));
    }

    // Add scroll listener for pagination
    _scrollController.addListener(_onScroll);
  }

  @override
  void didUpdateWidget(covariant FilteredCars oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.filter != widget.filter) {
      _currentPage = 1;
      // Dispatch search event only if the filter is not empty
      if (widget.filter.trim().isNotEmpty) {
        context.read<VehicleBloc>().add(SearchVehiclesEvent(
              query: widget.filter,
              page: _currentPage,
              limit: _limit,
            ));
      }
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      final currentState = context.read<VehicleBloc>().state;
      if (currentState is SearchVehicleState && currentState.hasMore) {
        _currentPage++;
        context.read<VehicleBloc>().add(SearchVehiclesEvent(
              query: widget.filter,
              page: _currentPage,
              limit: _limit,
            ));
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VehicleBloc, VehicleState>(
      builder: (context, state) {
        // Loading state
        if (state is SearchVehicleLoading && _currentPage == 1) {
          return const Center(
            heightFactor: 10,
            child: CircularProgressIndicator(),
          );
        }

        // Error state
        if (state is SearchVehicleFailure) {
          showSnackbar(context, state.message);
        }

        // Success state with results
        if (state is SearchVehicleState) {
          final searchResults = state.searchResults;

          if (searchResults.isEmpty && _currentPage == 1) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.directions_car_outlined,
                      size: 100, color: Colors.grey),
                  SizedBox(height: 20),
                  Text(
                    'No cars match your search.',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Try adjusting your filters or searching in a different area.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Filtered Vehicles", // Title for the filtered results
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 540,
                  child: ListView.builder(
                    shrinkWrap: true,
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    itemCount: searchResults.length + (state.hasMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == searchResults.length) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }

                      final car = searchResults[index];
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
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(18.0),
                                    topRight: Radius.circular(18.0),
                                  ),
                                  child: CustomImage(
                                    imageUrl: car.gallery![0],
                                    height: 190,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        car.model, // Vehicle model
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: AppPalette.primaryColor,
                                            size: 19,
                                          ),
                                          const SizedBox(width: 4.0),
                                          Text(
                                            car.rating?.toStringAsFixed(2) ??
                                                "No rating",
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
                                      horizontal: 8.0),
                                  child: Text(
                                    car.available
                                        ? "Currently Available "
                                        : "Currently Unavailable",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: car.available
                                          ? Colors.green[600]
                                          : Colors.red[
                                              600], // Green for availability
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8.0),
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
                                            Icons.event_seat,
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
                                            Icons.money,
                                            size: 16,
                                            color: AppPalette.primaryColor,
                                          ),
                                          const SizedBox(width: 4.0),
                                          PriceDisplay(
                                            price: "${car.pricePerHour}/hr",
                                            textColor: Colors.black54,
                                            priceFontSize: 12,
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
              ],
            ),
          );
        }

        // Default fallback
        return const SizedBox(
          height: 0,
          child: Center(
            child: Text(''),
          ),
        );
      },
    );
  }
}

import 'package:car_rent/core/common/bloc/profile/profile_bloc.dart';
import 'package:car_rent/core/common/entities/profile.dart';
import 'package:car_rent/core/common/widgets/custom_image.dart';
import 'package:car_rent/core/common/widgets/price_display.dart';
import 'package:car_rent/core/theme/app_pallete.dart';
import 'package:car_rent/core/utils/show_snackbar.dart';
import 'package:car_rent/features/car/presentation/bloc/vehicle_bloc.dart';
import 'package:car_rent/features/car/presentation/pages/car_details_page.dart';
import 'package:car_rent/features/host/presentation/widgets/shimmer_loading_list.dart';
import 'package:car_rent/features/messaging/presentation/pages/message_page.dart';
import 'package:car_rent/features/messaging/presentation/pages/rental_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesPage extends StatefulWidget {
  FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  Profile? _currentUserProfile;

  @override
  void initState() {
    super.initState();
    final profileState = context.read<ProfileBloc>().state;
    if (profileState is ProfileLoadSuccess) {
      _currentUserProfile = profileState.profile;
      _fetchFavoriteVehicles();
    }
  }

  void _fetchFavoriteVehicles() {
    final favorites = _currentUserProfile?.favorites;
    if (favorites != null) {
      context.read<VehicleBloc>().add(FetchFavoriteVehiclesEvent(favorites));
    }
  }

  void _removeFavoriteVehicle(
      BuildContext context, Profile profile, int vehicleId) {
    // Create a new profile with the vehicleId removed from favorites
    final updatedProfile = profile.copyWith(
      favorites:
          profile.favorites?.where((id) => id != vehicleId).toList() ?? [],
    );

    // Dispatch UpdateProfileEvent with the modified profile
    context.read<ProfileBloc>().add(UpdateProfileEvent(updatedProfile));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("My Favorites"),
        centerTitle: true,
      ),
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoadSuccess) {
            context
                .read<VehicleBloc>()
                .add(FetchFavoriteVehiclesEvent(state.profile.favorites!));
          }
          // TODO: implement listener
        },
        child: BlocBuilder<VehicleBloc, VehicleState>(
          builder: (context, state) {
            if (state is FavoriteVehiclesLoading) {
              return const ShimmerLoadingList(
                itemCount: 1,
                cardWidth: 350,
              );
            } else if (state is FavoriteVehiclesLoadSuccess) {
              final cars = state.vehicles;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: cars.isEmpty
                    ? _nofavourites()
                    : ListView.builder(
                        itemCount: cars.length,
                        itemBuilder: (context, index) {
                          final car = cars[index];
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
                                      Positioned(
                                        top: 12.0,
                                        right: 12.0,
                                        child: GestureDetector(
                                          onTap: () {
                                            if (_currentUserProfile != null) {
                                              _removeFavoriteVehicle(context,
                                                  _currentUserProfile!, car.id);
                                            }
                                          },
                                          child: const Icon(
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          car.model,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        const SizedBox(height: 4.0),
                                        Text(
                                          car.available
                                              ? "Available"
                                              : "Unavailable",
                                          style: const TextStyle(
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
                                                const Icon(
                                                  Icons
                                                      .airline_seat_recline_normal,
                                                  size: 16,
                                                  color:
                                                      AppPalette.primaryColor,
                                                ),
                                                const SizedBox(width: 4.0),
                                                Text(
                                                  car.seatingCapacity
                                                      .toString(),
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
                                                  color:
                                                      AppPalette.primaryColor,
                                                ),
                                                const SizedBox(width: 4.0),
                                                PriceDisplay(
                                                  price:
                                                      "${car.pricePerHour.toStringAsFixed(2)}",
                                                  priceFontSize: 12,
                                                  textColor: Colors.black54,
                                                  showPerHour: true,
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                AppPalette.primaryColor,
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CarDetailsPage(
                                                  vehicle: car,
                                                ),
                                              ),
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.directions_car,
                                            color: Colors.white,
                                          ),
                                          label: const Text(
                                            "Book Now",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            // Proceed to payment logic
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const RentalListPage(),
                                              ),
                                            );
                                          },
                                          child: const Text(
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
              );
            } else if (state is TopRatedVehicleFailure) {
              showSnackbar(context, state.message);
            }
            return const Center(child: Text("No data available."));
          },
        ),
      ),
    );
  }

  Widget _nofavourites() {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.directions_car_filled,
            size: 48,
            color: Colors.black54,
          ),
          SizedBox(height: 12),
          Text(
            "No favorite vehicles yet",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 6),
          Text(
            "Tap the heart icon to add favorites.",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}

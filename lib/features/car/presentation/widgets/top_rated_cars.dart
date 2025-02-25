import 'package:car_rent/core/common/bloc/profile/profile_bloc.dart';
import 'package:car_rent/core/common/entities/profile.dart';
import 'package:car_rent/core/utils/show_snackbar.dart';
import 'package:car_rent/features/host/presentation/widgets/shimmer_loading_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:car_rent/core/common/widgets/custom_image.dart';
import 'package:car_rent/core/theme/app_pallete.dart';
import 'package:car_rent/features/car/presentation/bloc/vehicle_bloc.dart';
import 'package:car_rent/features/car/presentation/pages/car_details_page.dart';
import 'package:shimmer/shimmer.dart';

class TopRatedCarsSection extends StatefulWidget {
  const TopRatedCarsSection({Key? key}) : super(key: key);

  @override
  State<TopRatedCarsSection> createState() => _TopRatedCarsSectionState();
}

class _TopRatedCarsSectionState extends State<TopRatedCarsSection> {
  late ScrollController _scrollController;
  final int _limit = 7; // Number of items to fetch per request
  Profile? _currentUserProfile;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    // Trigger the initial fetch for top-rated vehicles
    context.read<VehicleBloc>().add(FetchTopRatedVehiclesEvent(limit: _limit));
    final profileState = context.read<ProfileBloc>().state;
    print("profilestate: ${profileState}");
    if (profileState is ProfileLoadSuccess) {
      _currentUserProfile = profileState.profile;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoadSuccess) {
          setState(() {
            _currentUserProfile = state.profile;
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Top Rated Cars",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12.0),
            SizedBox(
              height: 230,
              child: BlocBuilder<VehicleBloc, VehicleState>(
                builder: (context, state) {
                  if (state is TopRatedVehicleLoading) {
                    return const ShimmerLoadingList();
                  } else if (state is TopRatedVehicleState) {
                    final cars = state.topRatedVehicles;
                    if (cars.isEmpty) {
                      return const Center(
                        child: Text(
                          "No top-rated cars available.",
                          style: TextStyle(color: Colors.black54),
                        ),
                      );
                    }
                    return ListView.builder(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: cars.length,
                      itemBuilder: (context, index) {
                        final car = cars[index];
                        final bool isFavorite =
                            _currentUserProfile?.favorites?.contains(car.id) ??
                                false;

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
                                        Positioned(
                                          top: 8.0,
                                          right: 8.0,
                                          child: GestureDetector(
                                            onTap: () {
                                              if (_currentUserProfile != null) {
                                                !isFavorite
                                                    ? context
                                                        .read<ProfileBloc>()
                                                        .add(
                                                          AddFavoriteEvent(
                                                              _currentUserProfile!
                                                                  .id,
                                                              car.id),
                                                        )
                                                    : _removeFavoriteVehicle(
                                                        context,
                                                        _currentUserProfile!,
                                                        car.id);
                                              } else {
                                                // Handle null case (e.g., show a message or log it)
                                                print("User profile is null");
                                              }
                                            },
                                            child: Icon(
                                              (isFavorite)
                                                  ? Icons.favorite
                                                  : Icons.favorite_outline,
                                              color: AppPalette.primaryColor,
                                              size: 24,
                                            ),
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
                                                  color:
                                                      AppPalette.primaryColor,
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
                                                  color:
                                                      AppPalette.primaryColor),
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
                                                  color:
                                                      AppPalette.primaryColor),
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
                  } else if (state is TopRatedVehicleFailure) {
                    showSnackbar(context, state.message);
                  }
                  return const Center(child: Text("No data available."));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

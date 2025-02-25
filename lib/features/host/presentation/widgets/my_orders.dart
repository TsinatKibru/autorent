import 'package:car_rent/core/common/bloc/wallet/wallet_bloc.dart';
import 'package:car_rent/core/common/bloc/wallet/wallet_event.dart';
import 'package:car_rent/core/common/bloc/wallet/wallet_state.dart';
import 'package:car_rent/core/common/constants.dart';
import 'package:car_rent/core/common/entities/location.dart';
import 'package:car_rent/core/common/entities/wallet.dart';
import 'package:car_rent/core/utils/location_selector.dart';
import 'package:car_rent/core/utils/location_utils.dart';
import 'package:car_rent/features/car/presentation/bloc/vehicle_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:car_rent/core/common/bloc/profile/profile_bloc.dart';
import 'package:car_rent/core/common/bloc/trip/trip_bloc.dart';
import 'package:car_rent/core/common/entities/profile.dart';
import 'package:car_rent/core/common/entities/trip.dart';
import 'package:car_rent/core/common/widgets/custom_image.dart';
import 'package:car_rent/core/theme/app_pallete.dart';
import 'package:car_rent/core/utils/date_time_utils.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  Profile? _currentUserProfile;
  String _selectedStatus = 'pending';
  Wallet? _wallet;
  late ScrollController _scrollController;
  int _offset = 0;
  final int _limit = 15; // Adjust as needed

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    // _scrollController.addListener(_onScroll);
    final profileState = context.read<ProfileBloc>().state;
    if (profileState is ProfileLoadSuccess) {
      _currentUserProfile = profileState.profile;
      if (_currentUserProfile != null) {
        context.read<TripBloc>().add(FetchTripsByProfileIdEvent(
              profileId: _currentUserProfile!.id,
              host: true,
              offset: _offset,
              limit: _limit,
            ));
      }
      _fetchTrips();

      _fetchWallets();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _fetchTrips() {
    if (_currentUserProfile != null) {
      context.read<TripBloc>().add(
            SubscribeToTripsChangesEvent(
              profileId: _currentUserProfile!.id,
              host: true,
              offset: _offset,
              limit: _limit,
            ),
          );
      // context.read<TripBloc>().add(FetchTripsByProfileIdEvent(
      //       profileId: _currentUserProfile!.id,
      //       host: true,
      //       offset: _offset,
      //       limit: _limit,
      //     ));
    }
  }

  void _nextPage() {
    setState(() {
      _offset += _limit;
    });
    _fetchTrips();
  }

  void _previousPage() {
    if (_offset > 1) {
      setState(() {
        _offset -= _limit;
      });
      _fetchTrips();
    }
  }

  void _fetchWallets() {
    if (_currentUserProfile != null) {
      context.read<WalletBloc>().add(FetchWalletEvent(_currentUserProfile!.id));
    }
  }

  void confimCompletion(BuildContext context, Trip trip) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Completion"),
          content: const Text(
              "Are you sure you want to mark this trip as completed?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                context
                    .read<TripBloc>()
                    .add(UpdateTripStatusEvent(trip.id, "completed"));

                context.read<VehicleBloc>().add(UpdateVehicleEvent(
                    trip.vehicle.id, trip.vehicle.copyWith(available: true)));
              },
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
              child: const Text("Confirm"),
            ),
          ],
        );
      },
    );
  }

  void verify(BuildContext context, Trip order) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Verify Renter Details"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Profile Image
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CustomImage(
                  imageUrl:
                      order.profile.avatar ?? "https://via.placeholder.com/100",
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),

              // Name
              Text(
                "Name: ${order.profile.name.toUpperCase()} ${order.profile.lastName?.toUpperCase()}",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),

              // Phone
              Text(
                "Phone: ${order.profile.phoneNumber}",
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const SizedBox(height: 10),

              // Driver's License Image
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CustomImage(
                  imageUrl: order.profile.driverLicenseImageUrl ??
                      "https://via.placeholder.com/150",
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),

              const Text(
                "Driver's License",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Implement actual verification logic here

                context
                    .read<TripBloc>()
                    .add(UpdateTripStatusEvent(order.id, "active"));
              },
              style: OutlinedButton.styleFrom(
                // Primary color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
              child: const Text("Verify"),
            ),
          ],
        );
      },
    );
  }

  void _updatewallet(Trip trip) {
    if (trip.status == "active" && _wallet != null) {
      context.read<VehicleBloc>().add(UpdateVehicleEvent(trip.vehicle.id,
          trip.vehicle.copyWith(available: false, activeStatus: true)));

      final double commision = Constants.commisionrate * trip.totalCost;

      context.read<WalletBloc>().add(UpdateWalletBalanceEvent(
          _currentUserProfile!.id,
          _wallet!.balance - commision,
          "debit",
          commision));
    }
  }

  void _updateTripStatus(BuildContext context, Trip trip, String status) {
    if (status == "active") {
      verify(context, trip);
    } else if (status == "completed") {
      confimCompletion(context, trip);
    } else if (status == "final") {
      return;
    } else {
      if (_wallet!.balance < trip.totalCost) {
        showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.error(
            message: "You have insufficient balance!",
          ),
        );

        context.read<VehicleBloc>().add(UpdateVehicleEvent(
            trip.vehicle.id, trip.vehicle.copyWith(activeStatus: false)));
        return;
      }
      context.read<TripBloc>().add(UpdateTripStatusEvent(trip.id, status));
    }
  }

  void _showSnackbar(BuildContext context, String message) {
    if (mounted) {
      setState(() {
        if (_selectedStatus == 'pending') {
          _selectedStatus = 'accepted';
        } else if (_selectedStatus == 'accepted') {
          _selectedStatus = 'active';
        } else if (_selectedStatus == 'active') {
          _selectedStatus = 'completed';
        }
        // No changes for 'completed' or 'cancelled'
      });
    }

    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.success(
        message: message,
        backgroundColor: const Color.fromARGB(255, 4, 190, 100),
      ),
    );
  }

  void openGoogleMaps(double latitude, double longitude) async {
    final Uri googleMapsUri =
        Uri.parse("geo:$latitude,$longitude?q=$latitude,$longitude");

    if (await canLaunchUrl(googleMapsUri)) {
      await launchUrl(googleMapsUri);
    } else {
      // Fallback to web Google Maps
      final Uri webUrl = Uri.parse(
          "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude");
      await launchUrl(webUrl);
    }
  }

  Widget _buildStatusButton(String label, String status) {
    bool isSelected = _selectedStatus == status;

    return TextButton(
      onPressed: () => WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() => _selectedStatus = status);
      }),
      style: TextButton.styleFrom(
        backgroundColor:
            isSelected ? AppPalette.primaryColor : Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: isSelected ? AppPalette.primaryColor : Colors.black12,
            width: 1.0,
          ),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocConsumer<WalletBloc, WalletState>(
            listener: (context, walletState) {
              print("walletState:${walletState}");
              if (walletState is WalletLoadSuccess) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    _wallet = walletState.wallet;
                  });
                });
                if (_currentUserProfile?.walletId == null) {
                  final updatedProfile = _currentUserProfile!.copyWith(
                    walletId: walletState.wallet.id,
                    updatedAt: DateTime.now(),
                  );
                  context
                      .read<ProfileBloc>()
                      .add(UpdateProfileEvent(updatedProfile));
                }
              }
            },
            builder: (context, walletState) {
              return const SizedBox(); // 🛠️ Empty widget as placeholder
            },
          ),
          const Text(
            "My Orders",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
          const SizedBox(height: 12.0),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildStatusButton("Pending", 'pending'),
                const SizedBox(width: 10),
                _buildStatusButton("Accepted", 'accepted'),
                const SizedBox(width: 10),
                _buildStatusButton("Active", 'active'),
                const SizedBox(width: 10),
                _buildStatusButton("Completed", 'completed'),
              ],
            ),
          ),
          BlocConsumer<TripBloc, TripState>(
            listener: (context, state) {
              if (state is TripStatusUpdated) {
                print(_wallet!.balance);
                print("_wallet!.balance");

                _fetchTrips();
                _updatewallet(state.trip);
                _showSnackbar(
                  context,
                  "Rental status updated successfully!",
                );
              }
            },
            builder: (context, state) {
              if (state is TripLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is TripFailure) {
                return const Center(
                    child: Text("Orders load failed",
                        style: TextStyle(
                          fontSize: 16,
                        )));
              } else if (state is TripLoadSuccess) {
                List<Trip> orders = state.trips
                    .where((trip) => trip.status == _selectedStatus)
                    .toList();
                if (orders.isEmpty) {
                  return _noOrders();
                }
                return Column(
                  children: [
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_ios),
                            onPressed: _previousPage,
                            tooltip: 'Previous Page',
                          ),
                          Text(
                              'Page ${_offset == 0 ? 1 : (_offset / _limit).toInt() + 1}'),
                          IconButton(
                            icon: const Icon(Icons.arrow_forward_ios),
                            onPressed: _nextPage,
                            tooltip: 'Next Page',
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                      controller: _scrollController,
                      shrinkWrap: true,
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        final order = orders[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Card(
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0)),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(12.0),
                                      bottomLeft: Radius.circular(12.0)),
                                  child: CustomImage(
                                    imageUrl: order.vehicle.gallery![0],
                                    height: 140,
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                order.vehicle.model,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ),
                                            // IconButton(
                                            //   icon: const Icon(
                                            //       Icons.location_on,
                                            //       color:
                                            //           AppPalette.primaryColor),
                                            //   onPressed: () {
                                            //     Location pickupLocation =
                                            //         LocationUtils.parseLocation(
                                            //             order.pickupLocation);
                                            //     // Navigate to the LocationPicker and pass the pickup location
                                            //     Navigator.push(
                                            //       context,
                                            //       MaterialPageRoute(
                                            //         builder: (context) =>
                                            //             LocationPicker(
                                            //                 onLocationSelected:
                                            //                     (location) {
                                            //                   print(
                                            //                       "Selected Location: $location");
                                            //                 },
                                            //                 initialLocation:
                                            //                     pickupLocation),
                                            //       ),
                                            //     );
                                            //   },
                                            // ),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.location_on,
                                                color: AppPalette.primaryColor,
                                              ),
                                              onPressed: () {
                                                Location pickupLocation =
                                                    LocationUtils.parseLocation(
                                                        order.pickupLocation);

                                                // Open Google Maps
                                                openGoogleMaps(
                                                    pickupLocation.latitude,
                                                    pickupLocation.longitude);
                                              },
                                            ),
                                          ],
                                        ),
                                        Text(
                                            "Due: ${DateTimeUtils.getMonthName(order.startTime.month)} ${order.startTime.day} ${order.startTime.year}, ${DateTimeUtils.getFormattedTime(order.startTime)}",
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.black54)),
                                        Text("For:${order.totalCost} Birr",
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black87)),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: ElevatedButton(
                                            onPressed: () => _updateTripStatus(
                                              context,
                                              order,
                                              order.status == 'pending'
                                                  ? 'accepted'
                                                  : order.status == 'accepted'
                                                      ? 'active'
                                                      : order.status == 'active'
                                                          ? 'completed'
                                                          : order.status ==
                                                                  'completed'
                                                              ? 'final'
                                                              : order.status,
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  AppPalette.primaryColor,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0)),
                                            ),
                                            child: Text(
                                                order.status == 'pending'
                                                    ? "Accept"
                                                    : order.status == 'accepted'
                                                        ? "Verify"
                                                        : order.status ==
                                                                'active'
                                                            ? "Complete"
                                                            : "Completed",
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                );
              }
              return const Center(
                  child: Text('Please wait...',
                      style: TextStyle(fontSize: 16, color: Colors.grey)));
            },
          ),
        ],
      ),
    );
  }

  Widget _noOrders() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: _previousPage,
                  tooltip: 'Previous Page',
                ),
                Text(
                    'Page ${_offset == 0 ? 1 : (_offset / _limit).toInt() + 1}'),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: () {},
                  tooltip: 'Next Page',
                  color: Colors.grey[200],
                ),
              ],
            ),
          ),
          const Icon(
            Icons.car_rental,
            size: 48,
            color: Colors.grey,
          ),
          const SizedBox(height: 12),
          const Text(
            "No rental orders found",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            "Your car rental bookings will appear here.",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

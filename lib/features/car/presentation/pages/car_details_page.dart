import 'dart:ffi';

import 'package:car_rent/core/common/bloc/profile/profile_bloc.dart';
import 'package:car_rent/core/common/bloc/profile/vehicle_owner/bloc/vehicle_owner_profile_bloc.dart';
import 'package:car_rent/core/common/entities/profile.dart';
import 'package:car_rent/core/common/widgets/price_display.dart';
import 'package:car_rent/core/theme/app_pallete.dart';
import 'package:car_rent/core/utils/dialog_helper.dart';
import 'package:car_rent/core/utils/show_snackbar.dart';
import 'package:car_rent/features/car/domain/entities/vehicle.dart';
import 'package:car_rent/features/car/presentation/widgets/car_images_carousel.dart';
import 'package:car_rent/features/car/presentation/widgets/car_rent_gradient_button.dart';
import 'package:car_rent/features/car/presentation/widgets/description_widget.dart';
import 'package:car_rent/features/car/presentation/widgets/guide_lines.dart';
import 'package:car_rent/features/car/presentation/widgets/host_details_card.dart';
import 'package:car_rent/features/car/presentation/widgets/request_to_book.dart';
import 'package:car_rent/features/car/presentation/widgets/reviews.dart';
import 'package:car_rent/features/car/presentation/widgets/trip_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarDetailsPage extends StatefulWidget {
  final Vehicle vehicle;

  const CarDetailsPage({
    Key? key,
    required this.vehicle,
  }) : super(key: key);

  @override
  _CarDetailsPageState createState() => _CarDetailsPageState();
}

class _CarDetailsPageState extends State<CarDetailsPage> {
  Profile? _currentUserProfile;
  DateTime? _selectedInitialDate;
  DateTime? _selectedReturnDate;
  String? selectedPickupLocation;
  String? selectedReturnLocation;
  double? price;

  void _handlePickupAndReturnSelection(
      String pickup, String returnLocation, double setprice) {
    setState(() {
      selectedPickupLocation = pickup;
      selectedReturnLocation = returnLocation;
      price = setprice;
    });
    print("Selected Pickup Location: $selectedPickupLocation");
    print("Selected Return Location: $selectedReturnLocation");
    print("Price: $price");
  }

  void _updateTripDates(Map<String, dynamic> dates) {
    setState(() {
      final initialDate = dates['initialDate'] as DateTime;
      final returnDate = dates['returnDate'] as DateTime;
      final initialTimeMinutes = dates['initialTime'] as double;
      final returnTimeMinutes = dates['returnTime'] as double;

      // Convert minutes into hours and minutes
      final initialHour = (initialTimeMinutes ~/ 60);
      final initialMinute = (initialTimeMinutes % 60).toInt();
      final returnHour = (returnTimeMinutes ~/ 60);
      final returnMinute = (returnTimeMinutes % 60).toInt();

      // Merge time into the date
      _selectedInitialDate = DateTime(
        initialDate.year,
        initialDate.month,
        initialDate.day,
        initialHour,
        initialMinute,
      );

      _selectedReturnDate = DateTime(
        returnDate.year,
        returnDate.month,
        returnDate.day,
        returnHour,
        returnMinute,
      );

      // Logging the updates
      print("Selected Initial Date with Time: $_selectedInitialDate");
      print("Selected Return Date with Time: $_selectedReturnDate");
    });
  }

  String _formatSliderTime(double minutes) {
    final hours = minutes ~/ 60;
    final remainingMinutes = minutes % 60;
    return "${hours.toString().padLeft(2, '0')}:${remainingMinutes.toInt().toString().padLeft(2, '0')}";
  }

  @override
  void initState() {
    super.initState();

    // Trigger the initial fetch for top-rated vehicles
    context
        .read<VehicleOwnerProfileBloc>()
        .add(FetchVehicleOwnerProfileEvent(widget.vehicle.host));
    final profileState = context.read<ProfileBloc>().state;
    if (profileState is ProfileLoadSuccess) {
      _currentUserProfile = profileState.profile;
    }
  }

  @override
  Widget build(BuildContext context) {
    final vehicle = widget.vehicle;
    print("here we go: ${_currentUserProfile.toString()} ");

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
                CarImageCarousel(carImages: vehicle.gallery ?? []),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          "${vehicle.brand} ${vehicle.model}",
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          overflow: TextOverflow
                              .ellipsis, // Truncates text with "..."
                          maxLines: 1, // Optional: Limits to a single line
                        ),
                      ),
                      PriceDisplay(
                        price: "${vehicle.pricePerHour}",
                        showPerHour: true,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      const Icon(Icons.star,
                          color: AppPalette.primaryColor, size: 20),
                      const SizedBox(width: 4.0),
                      Text(
                        vehicle.rating?.toStringAsFixed(2) ?? "No rating",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        "• ${vehicle.numberOfDoors} doors",
                        style: const TextStyle(
                            fontSize: 14, color: Colors.black54),
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
                // HostDetails(host: vehicle.host),
                const HostDetails(),
                const SizedBox(height: 24.0),
                TripOptions(
                  onTripDatesSelected: _updateTripDates,
                  onPickupAndReturnSelected: _handlePickupAndReturnSelection,
                  hostId: vehicle.host,
                ),
                const SizedBox(height: 30.0),
                // DescriptionWidget(description: vehicle.descriptionNote ?? ""),
                DescriptionWidget(vehicle: vehicle),
                const SizedBox(height: 30),
                ReviewsSection(
                  vehicleId: vehicle.id,
                ),
                const SizedBox(height: 30),
                // GuideLines(guidelines: vehicle.guidelines ?? "No guidelines"),
                GuideLines(guidelinesnote: vehicle.guidelines ?? ""),
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
                                PriceDisplay(
                                  price: "${vehicle.pricePerHour}",
                                  textColor: Colors.white,
                                  priceFontSize: 20,
                                  showPerHour: true,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                if (vehicle.previousPricePerHour != null)
                                  PriceDisplay(
                                    price: "${vehicle.previousPricePerHour}",
                                    textColor: Colors.white60,
                                    lineThrough: true,
                                    showPerHour: true,
                                  ),
                              ],
                            ),
                            CarRentGradientButton(
                              buttonText: "Book Now",
                              onPressed: () {
                                if (_selectedInitialDate == null ||
                                    _selectedReturnDate == null) {
                                  DialogHelper.showCustomSnackbar(
                                    context: context,
                                    message:
                                        'Please select both initial and return dates!',
                                    icon: Icons
                                        .error_outline, // A positive icon for feedback
                                    backgroundColor:
                                        Colors.teal[700]!, // Info color
                                    textColor: Colors
                                        .white, // Ensure the text is readable
                                    fontSize:
                                        18.0, // Suggested larger font size
                                    iconSize:
                                        32.0, // Suggested larger icon size
                                    borderRadius:
                                        16.0, // Suggested rounded corners
                                    elevation:
                                        10.0, // Suggested elevation for depth
                                    // Slightly shorter duration
                                  );

                                  return;
                                }

                                if (selectedPickupLocation == null ||
                                    selectedPickupLocation!.isEmpty) {
                                  DialogHelper.showCustomSnackbar(
                                    context: context,
                                    message: 'Please select a pickup location!',
                                    icon: Icons
                                        .error_outline, // A positive icon for feedback
                                    backgroundColor:
                                        Colors.teal[700]!, // Info color
                                    textColor: Colors
                                        .white, // Ensure the text is readable
                                    fontSize:
                                        18.0, // Suggested larger font size
                                    iconSize:
                                        32.0, // Suggested larger icon size
                                    borderRadius:
                                        16.0, // Suggested rounded corners
                                    elevation:
                                        10.0, // Suggested elevation for depth
                                    // Slightly shorter duration
                                  );
                                  // showSnackbar(context, "Please select a pickup location.");
                                  return;
                                }
                                if (price == null ||
                                    _currentUserProfile == null) {
                                  showSnackbar(
                                      context, "Unexpected error occurred");
                                  // showSnackbar(context, "Please select a pickup location.");
                                  return;
                                }

                                // Proceed with navigation if validations pass
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RequestToBook(
                                      initialdatetime: _selectedInitialDate!,
                                      vehicle: vehicle,
                                      returndatetime: _selectedReturnDate!,
                                      pickuplocation: selectedPickupLocation!,
                                      distancefee: price!,
                                      renterprofile: _currentUserProfile!,
                                    ),
                                  ),
                                );
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

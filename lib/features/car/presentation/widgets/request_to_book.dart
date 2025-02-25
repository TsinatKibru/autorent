import 'dart:ffi';

import 'package:car_rent/core/common/bloc/rental/rental_bloc.dart';
import 'package:car_rent/core/common/entities/profile.dart';
import 'package:car_rent/core/common/entities/rental.dart';
import 'package:car_rent/core/common/widgets/custom_image.dart';
import 'package:car_rent/core/common/widgets/price_display.dart';
import 'package:car_rent/core/utils/date_time_utils.dart';
import 'package:car_rent/core/utils/dialog_helper.dart';
import 'package:car_rent/core/utils/show_snackbar.dart';
import 'package:car_rent/features/car/domain/entities/vehicle.dart';
import 'package:car_rent/features/car/presentation/widgets/car_rent_gradient_button.dart';
import 'package:car_rent/features/car/presentation/widgets/get_approved_widget.dart';
import 'package:car_rent/features/navigation/presentation/widgets/bottom_navigation_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:car_rent/core/theme/app_pallete.dart';
import 'package:car_rent/features/car/presentation/widgets/payment_details.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestToBook extends StatelessWidget {
  final Vehicle vehicle;
  final DateTime initialdatetime;
  final DateTime returndatetime;
  final String pickuplocation;
  final double distancefee;
  final Profile renterprofile;
  const RequestToBook(
      {Key? key,
      required this.vehicle,
      required this.initialdatetime,
      required this.returndatetime,
      required this.pickuplocation,
      required this.distancefee,
      required this.renterprofile})
      : super(key: key);

  void _submitrental(BuildContext context, double tripFee) {
    try {
      Rental rental = Rental(
        id: 0,
        vehicleId: vehicle.id,
        profileId: renterprofile.id,
        hostId: vehicle.host,
        startTime: initialdatetime,
        endTime: returndatetime,
        pickupLocation: pickuplocation,
        totalCost: tripFee,
        status: "pending",
      );
      context.read<RentalBloc>().add(CreateRentalEvent(rental));
    } catch (e) {
      showSnackbar(context, 'Error creating rental: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final duration = returndatetime.difference(initialdatetime);

    final totalHours = (duration.inMinutes / 60).ceil();
    final tripFee = totalHours * vehicle.pricePerHour + distancefee;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Request to Book',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black87),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildCarImage(),
                        const SizedBox(width: 16.0),
                        _buildCarDetails(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Trip date & Time",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 227, 249, 228),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildDateTimeColumn(
                            "${initialdatetime.year} , ${DateTimeUtils.getMonthName(initialdatetime.month)} ${initialdatetime.day}",
                            DateTimeUtils.getFormattedTime(initialdatetime)),
                        const Icon(Icons.arrow_forward, color: Colors.green),
                        _buildDateTimeColumn(
                            "${initialdatetime.year} , ${DateTimeUtils.getMonthName(initialdatetime.month)} ${returndatetime.day}",
                            DateTimeUtils.getFormattedTime(returndatetime)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Pickup & Return",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          color: AppPalette.primaryColor, size: 24),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          pickuplocation,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black38,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  PaymentDetails(
                    initialdatetime: initialdatetime,
                    returndatetime: returndatetime,
                    distancefee: distancefee,
                    priceperhour: vehicle.pricePerHour,
                  ),
                  const SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.15,
            minChildSize: 0.05,
            maxChildSize: 0.4,
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
                          children: [
                            Text(
                              "Total: \$${tripFee.toStringAsFixed(2)}",
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            CarRentGradientButton(
                              buttonText: "Proceed to Pay",
                              width: 170,
                              onPressed: () {
                                print(
                                    "renterprofile.phoneNumber ${renterprofile.phoneNumber}");
                                if (renterprofile.avatar != null &&
                                    renterprofile.phoneNumber != null &&
                                    renterprofile.phoneNumber != "" &&
                                    renterprofile.driverLicenseImageUrl !=
                                        null &&
                                    renterprofile.driverLicenseImageUrl != "") {
                                  _submitrental(context, tripFee);
                                  // Navigate to BottomNavigationBarWidget if the profile is complete
                                  DialogHelper.showCustomSnackbar(
                                    context: context,
                                    message:
                                        'Your rental is confirmed! Track your Rental in the trips list.',
                                    icon: Icons.check_circle,
                                    backgroundColor:
                                        const Color.fromARGB(255, 6, 83, 18),
                                    duration: const Duration(seconds: 4),
                                    bottomMargin: 150,
                                  );
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) =>
                                  //         BottomNavigationBarWidget(
                                  //             initialIndex: 1),
                                  //   ),
                                  // );

                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BottomNavigationBarWidget(
                                                initialIndex: 1)),
                                    (Route<dynamic> route) =>
                                        false, // Removes all previous routes
                                  );
                                } else {
                                  Rental rental = Rental(
                                    id: 0,
                                    vehicleId: vehicle.id,
                                    profileId: renterprofile.id,
                                    hostId: vehicle.host,
                                    startTime: initialdatetime,
                                    endTime: returndatetime,
                                    pickupLocation: pickuplocation,
                                    totalCost: tripFee,
                                    status: "pending",
                                  );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          GetApprovedWidget(rental: rental),
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Select Payment Method",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        const SizedBox(height: 8),
                        const Row(
                          children: [
                            Icon(Icons.credit_card,
                                color: Colors.white, size: 20),
                            SizedBox(width: 8),
                            Text(
                              "Cash",
                              style: TextStyle(color: Colors.white),
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

  Widget _buildCarImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        height: 100,
        width: 100,
        child: CustomImage(
          imageUrl: vehicle.gallery![0],
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildCarDetails() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Model Name
          Text(
            "${vehicle.model} ${vehicle.brand}",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8.0),
          // Rating and Trips Info
          Row(
            children: [
              const Icon(Icons.star, color: AppPalette.primaryColor, size: 20),
              const SizedBox(width: 4.0),
              Text(
                vehicle.rating?.toStringAsFixed(2) ?? "No rating",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(width: 12.0),
              Text(
                "${vehicle.numberOfTrips.toString()} trips",
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          // Price
          Row(
            children: [
              const Icon(Icons.money, size: 20, color: Colors.green),
              const SizedBox(width: 4.0),
              PriceDisplay(
                price: "${vehicle.pricePerHour.toStringAsFixed(1)}",
                showPerHour: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDateTimeColumn(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
